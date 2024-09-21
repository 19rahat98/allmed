import 'dart:async';

import 'package:allmed/common/contants/global_common_constants.dart';
import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/payment/data/model/payment_3ds_response.dart';
import 'package:allmed/feature/payment/data/model/payment_card_model.dart';
import 'package:allmed/feature/payment/data/model/user_card_model.dart';
import 'package:allmed/feature/payment/data/repository/payment_repository.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:allmed/utils/extention/list_extention.dart';
import 'package:cloudpayments/cloudpayments.dart';

part 'payment_state.dart';

class PaymentCubit extends CoreCubit {
  /// Конструктор для инициализации кубита и передачи значения _orderId
  PaymentCubit()
      : _payment = sl(),
        super(PaymentCommonState());

  /// Идентификатор заказа
  int _orderId = -1;

  /// Репозиторий для работы с платежами
  final PaymentRepository _payment;
  List<UserCardModel> _cards = [];

  Future<void> getUserCards(int orderId) async {
    _orderId = orderId;
    final state = _commonState();
    final request = _payment.getUserCard();

    launchWithError<List<UserCardModel>, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (cards) => emit(
        state.copyWith(cardList: _cards = cards),
      ),
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }

  Future<void> deleteCard(int cardId) async {
    final state = _commonState();
    final request = _payment.deleteCard(cardId);

    launchWithError<void, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (_) {
        emit(SuccessCardDeleted());
        getUserCards(_orderId);
      },
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }

  Future<void> payWithToken(String? token) async {
    final state = _commonState();
    final request = _payment.payWithToken(_orderId, token ?? '');

    launchWithError<void, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (_) => emit(
        SuccessPaymentState(),
      ),
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }

  Future<void> selectCard(int cardId) async {
    final state = _commonState();
    final request = _payment.selectActiveCard(cardId);

    launchWithError<void, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (_) {
        emit(SuccessCardDeleted());
        getUserCards(_orderId);
      },
      errorData: (error) => emit(
        CoreHttpErrorState(error: error.message ?? S.current.errorOccurred),
      ),
    );
  }

  /// Метод для выполнения действия с картой: добавление новой карты или оплата с помощью карты
  void actionWithCard(PaymentCardModel card) {
    if (_orderId == GlobalCoreConstants.negative) {
      addNewCard(card);
      return;
    }
    payWithCard(card);
  }

  /// Метод для оплаты с помощью карты
  Future<void> payWithCard(PaymentCardModel card) async {
    final valid = _validateCard(card);
    if (!valid) return;

    final state = _commonState();
    try {
      final cryptogram = await Cloudpayments.cardCryptogram(
        cardCVC: card.cardCVC,
        cardDate: card.cardDate,
        cardNumber: card.cardNumber,
        publicId: GlobalCommonConstants.cloudPaymentApiKey,
      );
      final request = _payment.paymentWithCardCrypto(
        _orderId,
        cryptogram.cryptogram ?? GlobalCoreConstants.empty,
      );

      launchWithError<Payment3dsResponse?, HttpRequestException>(
        request: request,
        loading: (isLoading) => emit(
          state.copyWith(isLoading: true),
        ),
        resultData: (data) async {
          if (data == null) {
            emit(
              SuccessPaymentState(),
            );
            return;
          }

          final result = await Cloudpayments.show3ds(
            acsUrl: data.acsUrl,
            transactionId: data.transactionId.toString(),
            paReq: data.paReq,
          );

          await launch3ds(
            int.tryParse(result?.md ?? '1') ?? 0,
            result?.paRes ?? GlobalCoreConstants.empty,
            _orderId,
            onSuccess: (_) => emit(
              SuccessPaymentState(),
            ),
          );
        },
        errorData: (error) => emit(
          CoreHttpErrorState(error: S.current.errorOccurred),
        ),
      );
    } catch (e) {
      emit(
        CoreHttpErrorState(error: S.current.errorOccurred),
      );
    }
  }

  /// Метод для добавления новой карты
  Future<void> addNewCard(PaymentCardModel card) async {
    final valid = _validateCard(card);
    if (!valid) return;

    try {
      final state = _commonState();
      final cryptogram = await Cloudpayments.cardCryptogram(
        cardCVC: card.cardCVC,
        cardDate: card.cardDate,
        cardNumber: card.cardNumber,
        publicId: GlobalCommonConstants.cloudPaymentApiKey,
      );
      final request = _payment.saveNewCard(cryptogram.cryptogram ?? GlobalCoreConstants.empty);

      launchWithError<Payment3dsResponse?, HttpRequestException>(
        request: request,
        loading: (isLoading) => emit(
          state.copyWith(isLoading: true),
        ),
        resultData: (data) async {
          if (data == null) {
            emit(
              SuccessAddedNewCard(),
            );
            getUserCards(_orderId);
            return;
          }

          final result = await Cloudpayments.show3ds(
            acsUrl: data.acsUrl,
            transactionId: data.transactionId.toString(),
            paReq: data.paReq,
          );

          await launch3ds(
            int.tryParse(result?.md ?? '1') ?? 0,
            result?.paRes ?? GlobalCoreConstants.empty,
            _orderId,
            isSaveCard: true,
            onSuccess: (_) {
              emit(
                SuccessAddedNewCard(),
              );
              getUserCards(_orderId);
            },
          );
        },
        errorData: (error) => emit(
          CoreHttpErrorState(error: S.current.errorOccurred),
        ),
      );
    } catch (e) {
      emit(
        CoreHttpErrorState(error: S.current.errorOccurred),
      );
    }
  }

  /// Метод для запуска 3DS верификации
  Future<void> launch3ds(
    int transactionId,
    String paRes,
    int orderId, {
    bool isSaveCard = false,
    required Function(void) onSuccess,
  }) async {
    final state = _commonState();

    final request = _payment.verify3ds(transactionId, paRes, orderId, isSaveCard);
    launch(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: onSuccess,
    );
  }

  /// Валидация номера карты и CVV
  /// Возвращает [true] при успешной валидации
  bool _validateCard(PaymentCardModel card) {
    var valid = true;
    var errorCvv = GlobalCoreConstants.empty;
    var errorDate = GlobalCoreConstants.empty;
    var errorNumber = GlobalCoreConstants.empty;
    if (card.cardNumber.isEmpty) {
      errorNumber = S.current.fieldCantBeEmpty;
      valid = false;
    }
    if (card.cardNumber.isNotEmpty && card.cardNumber.length != 19) {
      valid = false;
      errorNumber = S.current.enterCorrectValue;
    }
    if (card.cardDate.isEmpty) {
      valid = false;
      errorDate = S.current.fieldCantBeEmpty;
    }
    if (card.cardDate.isNotEmpty && card.cardDate.length != 5) {
      valid = false;
      errorDate = S.current.enterCorrectValue;
    }
    if (card.cardCVC.isEmpty) {
      valid = false;
      errorCvv = S.current.fieldCantBeEmpty;
    }
    if (card.cardCVC.isNotEmpty && card.cardCVC.length != 3) {
      valid = false;
      errorCvv = S.current.enterCorrectValue;
    }

    if (!valid) {
      final state = _commonState();
      emit(
        state.copyWith(
          cardCvcError: errorCvv,
          cardDateError: errorDate,
          cardNumberError: errorNumber,
        ),
      );
    }

    return valid;
  }

  /// Метод для удаления ошибок валидации
  void removeErrors(String v) {
    final state = _commonState();
    emit(
      state.copyWith(
        cardCvcError: GlobalCoreConstants.empty,
        cardDateError: GlobalCoreConstants.empty,
        cardNumberError: GlobalCoreConstants.empty,
      ),
    );
  }

  /// Метод для получения текущего состояния
  PaymentCommonState _commonState() {
    if (state is PaymentCommonState) {
      return state as PaymentCommonState;
    }

    return PaymentCommonState(cardList: _cards);
  }
}

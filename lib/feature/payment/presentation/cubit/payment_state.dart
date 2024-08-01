part of 'payment_cubit.dart';

class PaymentCommonState extends CoreState {
  PaymentCommonState({
    this.cardList,
    this.cardCvcError,
    this.cardDateError,
    this.cardNumberError,
    this.isLoading = false,
    this.selectedCardId = -1,
  });

  final bool isLoading;
  final int selectedCardId;
  final String? cardCvcError;
  final String? cardDateError;
  final String? cardNumberError;
  final List<UserCardModel>? cardList;

  PaymentCommonState copyWith({
    bool? isLoading,
    int? selectedCardId,
    String? cardCvcError,
    String? cardDateError,
    String? cardNumberError,
    List<UserCardModel>? cardList,
  }) =>
      PaymentCommonState(
        cardList: cardList ?? this.cardList,
        isLoading: isLoading ?? this.isLoading,
        cardCvcError: cardCvcError ?? this.cardCvcError,
        cardDateError: cardDateError ?? this.cardDateError,
        selectedCardId: selectedCardId ?? this.selectedCardId,
        cardNumberError: cardNumberError ?? this.cardNumberError,
      );

  UserCardModel? get activeCard => cardList?.firstWhereNull((item) => item.active);

  bool get isCanBeLoad =>activeCard != null && isLoading;

  @override
  List<Object> get props => [
        isLoading,
        cardList ?? 0,
        selectedCardId,
        cardCvcError ?? 0,
        cardDateError ?? 0,
        cardNumberError ?? 0,
      ];
}

class SuccessPaymentState extends CoreState {}

class SuccessAddedNewCard extends CoreState {}

class SuccessCardDeleted extends CoreState {}

class Show3dsStepOfPaymentState extends CoreIndexedState {
  final Payment3dsResponse payment3dsResponse;

  Show3dsStepOfPaymentState(this.payment3dsResponse);
}

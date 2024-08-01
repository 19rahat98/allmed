import 'package:allmed/common/core/utils/mixins/request_worker_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core_state.dart';

abstract class CoreCubit extends Cubit<CoreState> with CoreRequestWorkedMixin {
  List<CoreRequestWorkedMixin>? _useCaseLaunchers;

  CoreCubit(
    CoreState state, {
    List<CoreRequestWorkedMixin>? useCaseLaunchers,
  }) : super(state) {
    _useCaseLaunchers = useCaseLaunchers;
    _useCaseLaunchers?.forEach((element) {
      element.showErrorHttpCallback = (String errorMessage, int code) {
        emit(CoreHttpErrorState(error: errorMessage, code: code));
      };

      element.showAuthErrorCallback = () {
        emit(CoreErrorAuthErrorState());
      };

      element.showErrorInternetConnection = (error) {
        emit(CoreNotInternetConnectionState(error: error));
      };
      element.showErrorExceptionCallback = (error) {
        emit(CoreErrorExceptionState(error: error));
      };
    });

    showErrorInternetConnection = (error) {
      emit(CoreNotInternetConnectionState(error: error));
    };

    showAuthErrorCallback = () {
      emit(CoreErrorAuthErrorState());
    };

    showErrorHttpCallback = (String errorMessage, int code) {
      emit(CoreHttpErrorState(error: errorMessage, code: code));
    };

    showErrorExceptionCallback = (error) {
      emit(CoreErrorExceptionState(error: error));
    };
  }

  @override
  Future<void> close() {
    _useCaseLaunchers?.forEach((element) {
      element.clear();
    });
    clear();
    return super.close();
  }
}

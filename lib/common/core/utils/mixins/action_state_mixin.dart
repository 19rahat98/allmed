import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// отслеживаем состояние которые нужно выполнить в базовых случаях
mixin ActionStateMixin {
  bool makeBuildWhenListener<S>(
    S prevState,
    S currentState, {
    BlocBuilderCondition<S>? buildWhen,
    Function()? httpErrorListener,
    Function()? noInternetConnectionListener,
    Function()? applicationExtensionListener,
  }) {
    /// в случае если нет интернет соеденения и загрузка была первичной
    if (currentState is CoreNotInternetConnectionState && prevState is CoreLoadingState) {
      noInternetConnectionListener?.call();

      return true;
    }

    /// в случае если произощел сбой в приложении и загрузка была первичной
    if (currentState is CoreErrorExceptionState && prevState is CoreLoadingState) {
      applicationExtensionListener?.call();
      return true;
    }

    /// в случае если произошла ошибка при http загрузке  и загрузка была первичной
    if (currentState is CoreHttpErrorState && prevState is CoreLoadingState) {
      httpErrorListener?.call();
      return true;
    }

    if (currentState is CoreNotInternetConnectionState ||
        currentState is CoreHttpErrorState ||
        currentState is CoreErrorExceptionState) {
      return false;
    }
    final value = buildWhen?.call(prevState, currentState) ?? false;
    return value;
  }

  /// отслеживаем ошибки
  /// [bool disableNetworkErrorMessages] - если true, то ошибки не показваются дефолтным образом в SnackBar
  void handleErrorListener({
    required CoreState prevState,
    required CoreState currentState,
    Function()? redirectLoginListener,
    Function(String error)? showSnackBar,
    Function(String error)? httpErrorListener,
    Function()? notInternetConnectionListener,
    Function()? applicationExceptionListener,
  }) {
    if (currentState is CoreHttpErrorState) {
      httpErrorListener == null
          ? showSnackBar?.call(currentState.error)
          : httpErrorListener.call(currentState.error);
    }

    if (currentState is CoreNotInternetConnectionState) {
      notInternetConnectionListener == null
          ? showSnackBar?.call(currentState.error)
          : notInternetConnectionListener.call();
    }

    if (currentState is CoreErrorExceptionState) {
      applicationExceptionListener == null
          ? showSnackBar?.call(currentState.error)
          : applicationExceptionListener.call();
    }

    if (currentState is CoreErrorAuthErrorState) {
      redirectLoginListener?.call();
    }
  }
}

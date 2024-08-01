import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/core/utils/mixins/action_state_mixin.dart';
import 'package:allmed/common/presentation/widgets/app_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// пользовательский блок в который следуем заносить весь базовый функционал связанные с UI
/// Содержит в себе только bulder
class CoreUpgradeBlocBuilder<C extends Cubit<S>, S extends CoreState> extends StatefulWidget {
  const CoreUpgradeBlocBuilder({
    super.key,
    required this.builder,
    this.cubit,
    this.httpErrorBuilder,
    this.notInternetConnectionBuilder,
    this.applicationExeptionBuilder,
    this.buildWhen,
    this.listenWhen,
    this.listener,
    this.httpErrorListener,
    this.redirectLoginListener,
    this.noInternetConnectionListener,
    this.applicationExceptionListener,
  });

  // final Function(String error, int code) error404Listener;
  // final Function(String error, int code) error500Listener;
  final Function(String error)? httpErrorListener;
  final Function()? noInternetConnectionListener;
  final Function()? applicationExceptionListener;
  final Function? redirectLoginListener;

  /// Функция [builder], которая будет вызываться при каждой сборке виджета.
  /// [Builder] принимает `BuildContext` и текущее` состояние` и
  /// должен возвращать виджет.
  /// Это аналог функции [builder] в [StreamBuilder].
  final BlocWidgetBuilder<S> builder;

  /// Функция [builder], которая будет вызываться при первом перестроении в случае ошибки,
  /// для того чтобы пользователь мог, позвторно сделать запрос
  /// [Builder] принимает `BuildContext` и текущее` состояние` и
  /// должен возвращать виджет.
  /// Это аналог функции [builder] в [StreamBuilder].
  final BlocWidgetBuilder<S>? httpErrorBuilder;

  /// Функция [builder], которая будет вызываться в случае отсутвия интернета при первичном запуске,
  /// для того чтобы пользователь мог, позвторно сделать запрос,
  /// послудущие разы, данные кульбэк вызываться не будет
  /// [Builder] принимает `BuildContext` и текущее` состояние` и
  /// должен возвращать виджет.
  /// Это аналог функции [builder] в [StreamBuilder].
  final BlocWidgetBuilder<S>? notInternetConnectionBuilder;

  /// Функция [builder], которая будет вызываться в случае сбоя в приложении при первичном запуске,
  /// для того чтобы пользователь мог, позвторно сделать запрос,
  /// послудущие разы, данные кульбэк вызываться не будет
  /// [Builder] принимает `BuildContext` и текущее` состояние` и
  /// должен возвращать виджет.
  /// Это аналог функции [builder] в [StreamBuilder].
  final BlocWidgetBuilder<S>? applicationExeptionBuilder;

  /// Принимает `BuildContext` вместе с [cubit]` state`
  /// и отвечает за выполнение в ответ на изменения состояния.
  final BlocWidgetListener<S>? listener;

  /// [Cubit], с которым будет взаимодействовать [BlocConsumer].
  /// Если не указано, [BlocConsumer] автоматически выполнит поиск, используя
  /// `BlocProvider` и текущий` BuildContext`.
  final C? cubit;

  /// Принимает предыдущее `состояние` и текущее` состояние` и отвечает за
  /// возвращаем [bool], который определяет, запускать или нет
  /// [строитель] с текущим `состоянием`.
  final BlocBuilderCondition<S>? buildWhen;

  /// Принимает предыдущее `состояние` и текущее` состояние` и отвечает за
  /// возвращаем [bool], который определяет, вызывать ли [listener] из
  /// [BlocConsumer] с текущим `состоянием`.
  final BlocListenerCondition<S>? listenWhen;

  @override
  _CoreUpgradeBlocBuilderState<C, S> createState() => _CoreUpgradeBlocBuilderState<C, S>();
}

class _CoreUpgradeBlocBuilderState<C extends Cubit<S>, S extends CoreState>
    extends State<CoreUpgradeBlocBuilder<C, S>> with ActionStateMixin {
  Widget? _widget;
  late CoreState _prevState;

  @override
  Widget build(BuildContext context) => BlocConsumer<C, S>(
        builder: (context, state) {
          final currentWidget = _widget ?? widget.builder.call(context, state);
          return currentWidget;
        },
        bloc: widget.cubit,
        buildWhen: (prevState, currentState) {
          _prevState = prevState;
          return makeBuildWhenListener(prevState, currentState, buildWhen: (ctx, state) {
            _widget = null;
            return widget.buildWhen?.call(ctx, state) ?? true;
          }, noInternetConnectionListener: () {
            _widget = widget.notInternetConnectionBuilder!(context, currentState);
          }, httpErrorListener: () {
            _widget = widget.httpErrorBuilder!(context, currentState);
          }, applicationExtensionListener: () {
            _widget = widget.applicationExeptionBuilder!(context, currentState);
          });
        },
        listenWhen: (prevState, state) {
          _prevState = prevState;
          return widget.listenWhen?.call(prevState, state) ?? true;
        },
        listener: (context, state) {
          handleErrorListener(
            prevState: _prevState,
            currentState: state,
            httpErrorListener: widget.httpErrorListener,
            showSnackBar: (error) => errorSnackBar(context, error),
            notInternetConnectionListener: widget.noInternetConnectionListener,
            applicationExceptionListener: widget.applicationExceptionListener,
          );
          widget.listener?.call(context, state);

        },
      );
}

import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_bars/common_app_bar.dart';
import 'package:allmed/common/presentation/widgets/app_expanded_item.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/presentation/widgets/app_loading_widget.dart';
import 'package:allmed/common/presentation/widgets/app_shimmer_widget.dart';
import 'package:allmed/feature/information/presentation/faq/cubit/faq_cubit.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key, this.isFromNavBar = true}) : super(key: key);

  final bool isFromNavBar;

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaqCubit()..getFaqList(),
      child: BlocBuilder<FaqCubit, CoreState>(
        builder: (context, state) {
          if (state is FaqListLoadedList) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CommonAppBar(S.current.support, enableBack: !widget.isFromNavBar),
              body: RefreshIndicator(
                onRefresh: context.read<FaqCubit>().getFaqList,
                child: ListView.separated(
                  itemCount: state.faqList.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  separatorBuilder: (_, __) => const HBox(16),
                  itemBuilder: (context, index) {
                    final item = state.faqList.elementAt(index);
                    return AppExpandedItem(
                      title: item.title,
                      subTitle: item.description,
                    );
                  },
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: context.read<FaqCubit>().getFaqList,
            );
          }

          final isLoading = state is FaqInitialState && state.isLoading;
          return AppLoadingWidget(
            isLoading: isLoading,
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: CommonAppBar(S.current.support, enableBack: !widget.isFromNavBar),
              body: RefreshIndicator(
                onRefresh: context.read<FaqCubit>().getFaqList,
                child: ListView.separated(
                  itemCount: 3,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  separatorBuilder: (_, __) => const HBox(16),
                  itemBuilder: (context, index) => SizedBox(
                    height: 70,
                    child: AppShimmerWidget(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

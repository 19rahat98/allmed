import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/presentation/screens/errors/404_error_page.dart';
import 'package:allmed/common/presentation/widgets/app_hbox_widget.dart';
import 'package:allmed/common/theme/app_theme.dart';
import 'package:allmed/feature/information/presentation/terms/cubit/terms_cubit.dart';
import 'package:allmed/utils/launcher_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class TermInfoScreen extends StatelessWidget {
  const TermInfoScreen(this.id, {super.key});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TermsCubit()..getTermInfo(id),
      child: BlocBuilder<TermsCubit, CoreState>(
        builder: (context, state) {
          if (state is TermsScreenState) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                state.data.title,
                                style: AppTextStyle.title1.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: HtmlWidget(state.data.content),
                    ),
                    const HBox(8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Text(
                        state.data.date,
                        style: AppTextStyle.base.copyWith(
                          color: AppColors.gray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Источник: ',
                          style: AppTextStyle.caption1,
                          children: <TextSpan>[
                            TextSpan(
                              text: state.data.linkName,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => launchLinks(state.data.link),
                              style: AppTextStyle.caption1.copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const HBox(40),
                  ],
                ),
              ),
            );
          } else if (state is CoreErrorExceptionState) {
            return NetworkErrorPage(
              onRefresh: () => context.read<TermsCubit>().getTermInfo(id),
            );
          }

          return const Scaffold();
        },
      ),
    );
  }
}

part of 'faq_cubit.dart';

class FaqInitialState extends CoreState {
  final bool isLoading;

  FaqInitialState(this.isLoading);
}

class FaqListLoadedList extends CoreState {
  final List<QuestionModel> faqList;

  FaqListLoadedList(this.faqList);
}

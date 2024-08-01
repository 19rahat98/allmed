import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/home_scren/data/repository/content_repository.dart';
import 'package:allmed/feature/information/data/model/faq_model.dart';

part 'faq_state.dart';

class FaqCubit extends CoreCubit {
  FaqCubit()
      : _repository = sl(),
        super(FaqInitialState(false));

  final ContentRepository _repository;

  Future<void> getFaqList() async {
    final request = _repository.getFAQ();
    await launchWithError<List<QuestionModel>, HttpRequestException>(
      request: request,
      loading: (isLoading) => emit(
        FaqInitialState(isLoading),
      ),
      resultData: (faq) => emit(
        FaqListLoadedList(faq),
      ),
      errorData: (error) => emit(
        CoreErrorExceptionState(error: error.message ?? GlobalCoreConstants.empty),
      ),
    );
  }
}

import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/common/exception/exception.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/home_scren/data/repository/content_repository.dart';
import 'package:allmed/feature/information/data/model/faq_model.dart';
import 'package:allmed/feature/information/data/model/term_model.dart';

part 'terms_state.dart';

class TermsCubit extends CoreCubit {
  TermsCubit()
      : _repository = sl(),
        super(
          TermsState(const []),
        );

  final ContentRepository _repository;

  Future<void> getTermsList() async {
    final request = _repository.getInformationList();
    await launchWithError<List<QuestionModel>, HttpRequestException>(
      request: request,
      resultData: (faq) => emit(
        TermsState(faq),
      ),
      errorData: (error) => emit(
        CoreErrorExceptionState(error: error.message ?? GlobalCoreConstants.empty),
      ),
    );
  }

  Future<void> getTermInfo(int id) async {
    final request = _repository.getInfoAboutTerm(id);
    await launchWithError<TermModel, HttpRequestException>(
      request: request,
      resultData: (data) => emit(
        TermsScreenState(data),
      ),
      errorData: (error) => emit(
        CoreErrorExceptionState(error: error.message ?? GlobalCoreConstants.empty),
      ),
    );
  }
}

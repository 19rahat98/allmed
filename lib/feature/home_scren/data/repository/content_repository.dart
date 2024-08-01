import 'package:allmed/common/data/network/authorized_api_service.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/home_scren/data/model/banner_model.dart';
import 'package:allmed/feature/information/data/model/faq_model.dart';
import 'package:allmed/feature/information/data/model/term_model.dart';
import 'package:allmed/utils/http_call_utils.dart';

class ContentRepository {
  ContentRepository() : _apiService = sl();

  final AuthorizedApiService _apiService;

  /// Получт список банеров для главной старинции
  Future<List<BannerModel>> getBanners() async {
    return safeApiCall(
      _apiService.bannerList(),
      BannerModel.fromJsonList,
    );
  }

  /// список FAQ
  Future<List<QuestionModel>> getFAQ() async {
    return safeApiCall(
      _apiService.faqList(),
      QuestionModel.fromJsonList,
    );
  }

  /// список документов
  Future<List<QuestionModel>> getInformationList() async {
    return safeApiCall(
      _apiService.termsList(),
      (data) => QuestionModel.fromJsonList(data, key: 'informations'),
    );
  }

  /// список документов
  Future<TermModel> getInfoAboutTerm(int id) async {
    return safeApiCall(_apiService.termsData(id), TermModel.fromJson);
  }
}

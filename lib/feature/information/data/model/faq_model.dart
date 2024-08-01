import 'package:allmed/common/contants/global_core_constants.dart';

class QuestionModel {
  QuestionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.active,
  });

  factory QuestionModel.fromJson(dynamic data) {
    final json = data as Map<String, dynamic>;
    return QuestionModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? GlobalCoreConstants.empty,
      description: json['description'] as String? ?? GlobalCoreConstants.empty,
      active: json['active'] as int? ?? 0,
    );
  }

  final int id;
  final String title;
  final String description;
  final int active;

  static List<QuestionModel> fromJsonList(Map<String, dynamic> json, {String? key}) {
    final questions = (json[key ?? 'questions'] as List<dynamic>).map(QuestionModel.fromJson);
    return questions.toList();
  }
}

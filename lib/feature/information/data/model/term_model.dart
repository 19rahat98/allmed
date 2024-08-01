import 'package:allmed/common/contants/global_pattern_constant.dart';
import 'package:intl/intl.dart';

class TermModel {
  final int id;
  final String title;
  final String content;
  final String link;
  final String linkName;
  final DateTime createdAt;
  final DateTime updatedAt;

  TermModel({
    required this.id,
    required this.title,
    required this.content,
    required this.link,
    required this.linkName,
    required this.createdAt,
    required this.updatedAt,
  });

  String get date => DateFormat(GlobalDatePatternConstant.ddMMyyyyKMHHmm).format(createdAt);

  factory TermModel.fromJson(Map<String, dynamic> data) {
    final json = data['information'];
    return TermModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      link: json['link'],
      linkName: json['link_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
import 'package:allmed/common/contants/global_core_constants.dart';

class UserCardModel {
  final int id;
  final int userId;
  final String cardFirstSix;
  final String cardLastFour;
  final String typeOfCard;
  final String token;
  final bool active;

  UserCardModel({
    this.active = false,
    this.id = GlobalCoreConstants.negative,
    this.userId = GlobalCoreConstants.negative,
    this.cardFirstSix = GlobalCoreConstants.empty,
    this.cardLastFour = GlobalCoreConstants.empty,
    this.typeOfCard = GlobalCoreConstants.empty,
    this.token = GlobalCoreConstants.empty,
  });

  factory UserCardModel.fromJson(Map<String, dynamic> json) {
    return UserCardModel(
      id: json['id'],
      userId: json['user_id'],
      cardFirstSix: json['card_first_six'],
      cardLastFour: json['card_last_four'],
      typeOfCard: json['type_of_card'],
      token: json['token'],
      active: json['active'] == 1,
    );
  }

  String get name => '$typeOfCard ***** $cardLastFour';

  bool get isVisa => typeOfCard == 'Visa';

  static List<UserCardModel> fromJsonList(Map<String, dynamic> json) {
    var list = json['user_cards'] as List<dynamic>? ?? [];
    final userCardsList = list.map((i) => UserCardModel.fromJson(i));

    return userCardsList.toList();
  }
}

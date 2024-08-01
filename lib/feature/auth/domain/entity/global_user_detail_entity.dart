import 'package:allmed/common/contants/global_core_constants.dart';

class GlobalUserDetailEntity {
  final int id;
  final String? iin;
  final int? gender;
  final String? name;
  final String? birthDay;
  final String? lastName;
  final String? middleName;
  final String phoneNumber;
  final int citizenshipStatus;

  GlobalUserDetailEntity({
    this.iin,
    this.name,
    this.id = 0,
    this.gender,
    this.birthDay,
    this.lastName,
    this.middleName,
    this.citizenshipStatus = 0,
    this.phoneNumber = GlobalCoreConstants.empty,
  });

  factory GlobalUserDetailEntity.fromJson(Map<String, dynamic> json) {
    final userJson = json['user'] as Map<String, dynamic>? ?? {};
    return GlobalUserDetailEntity(
      id: userJson['id'] as int,
      iin: userJson['iin'] as String?,
      name: userJson['name'] as String?,
      gender: userJson['gender'] as int?,
      birthDay: userJson['bdy'] as String?,
      lastName: userJson['last_name'] as String?,
      middleName: userJson['middle_name'] as String?,
      citizenshipStatus: userJson['in_kz'] as int? ?? 0,
      phoneNumber: userJson['phone_number'] as String? ?? GlobalCoreConstants.empty,
    );
  }

  String get firstSymbol => userName.substring(0, 1);

  String get userFullName => '$userName $userLastName';

  String get userName => name ?? GlobalCoreConstants.empty;

  String get userLastName => lastName ?? GlobalCoreConstants.empty;

  String get userPhoneNumber => '+$phoneNumber';

  String get shortNumber => phoneNumber.substring(1);

  bool get isFinishedRegistration => lastName != null && name != null;
}

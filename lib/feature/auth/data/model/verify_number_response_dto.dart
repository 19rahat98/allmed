import 'package:allmed/common/contants/global_core_constants.dart';

class VerifyNumberResponseDto {
  final String token;
  final String phoneNumber;

  VerifyNumberResponseDto({required this.token, required this.phoneNumber});

  factory VerifyNumberResponseDto.fromJson(Map<String, dynamic> json) => VerifyNumberResponseDto(
    token: json['token'] as String? ?? GlobalCoreConstants.empty,
    phoneNumber: json['phone_number'] as String? ?? GlobalCoreConstants.empty,
  );
}
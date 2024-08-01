import 'package:allmed/common/contants/global_core_constants.dart';

class CreateAccountResponseDto {
  final String phoneNumber;

  CreateAccountResponseDto({required this.phoneNumber});

  factory CreateAccountResponseDto.fromJson(Map<String, dynamic> json) => CreateAccountResponseDto(
        phoneNumber: json['phone_number'] as String? ?? GlobalCoreConstants.empty,
      );
}

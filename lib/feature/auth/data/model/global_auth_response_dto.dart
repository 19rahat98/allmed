import 'package:allmed/common/contants/global_core_constants.dart';

/// ответ для авторизации
class GlobalAuthResponseTokenDTO {
  GlobalAuthResponseTokenDTO({
    this.access = GlobalCoreConstants.empty,
    this.refresh = GlobalCoreConstants.empty,
  });

  factory GlobalAuthResponseTokenDTO.fromJson(Map<String, dynamic> json) =>
      GlobalAuthResponseTokenDTO(
        access: json['access_token'] as String? ?? GlobalCoreConstants.empty,
        refresh: json["refresh_token"] as String? ?? GlobalCoreConstants.empty,
      );

  final String access;
  final String refresh;
}

/// ответ для авторизации
class GlobalAuthResponseDTO {
  GlobalAuthResponseDTO({
    this.email,
    this.tokens,
    this.phoneVerified,
    this.emailVerified,
  });

  factory GlobalAuthResponseDTO.fromJson(Map<String, dynamic> json) => GlobalAuthResponseDTO(
        email: json['email'] as String?,
        emailVerified: json['email_verified'] as bool? ?? false,
        phoneVerified: json['phone_verified'] as bool? ?? false,
        tokens: GlobalAuthResponseTokenDTO.fromJson(
          json['tokens'] as Map<String, dynamic>,
        ),
      );

  final String? email;
  final bool? emailVerified;
  final bool? phoneVerified;
  final GlobalAuthResponseTokenDTO? tokens;
}

/// ответ для регистарции
class GlobalRegistrationResponseDTO {
  GlobalRegistrationResponseDTO({
    this.data,
    this.email,
    this.phoneNumber,
    this.id = GlobalCoreConstants.empty,
  });

  factory GlobalRegistrationResponseDTO.fromJson(Map<String, dynamic> json) {
    final dataValue = GlobalResponseDTO.fromJson(json);
    return GlobalRegistrationResponseDTO(
      email: json['email'] as String?,
      id: dataValue.data['account_id'] as String,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  final String id;
  final String? email;
  final String? phoneNumber;
  final GlobalResponseDTO? data;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

/// ответ с сервера с [data]
class GlobalResponseDTO {
  GlobalResponseDTO({required this.data});

  factory GlobalResponseDTO.fromJson(Map<String, dynamic> json) => GlobalResponseDTO(
        data: json['data'] as Map<String, dynamic>,
      );

  final Map<String, dynamic> data;
}

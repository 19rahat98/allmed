import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/feature/auth/data/model/global_auth_response_dto.dart';

/// ответ для авторизации
class GlobalAuthResponse {
  GlobalAuthResponse({
    this.phoneVerified,
    this.emailVerified,
    required this.email,
    required this.tokens,
  });

  factory GlobalAuthResponse.fromDTO(GlobalAuthResponseDTO dto) => GlobalAuthResponse(
        phoneVerified: dto.phoneVerified,
        emailVerified: dto.emailVerified,
        email: dto.email ?? GlobalCoreConstants.empty,
        tokens: GlobalAccessToken.fromDTO(dto.tokens),
      );

  final String email;
  final bool? phoneVerified;
  final bool? emailVerified;
  final GlobalAccessToken tokens;
}

class GlobalAccessToken {
  GlobalAccessToken({
    required this.access,
    required this.refresh,
  });

  factory GlobalAccessToken.fromDTO(GlobalAuthResponseTokenDTO? dto) => GlobalAccessToken(
        access: dto?.access ?? GlobalCoreConstants.empty,
        refresh: dto?.refresh ?? GlobalCoreConstants.empty,
      );

  final String access;
  final String refresh;
}

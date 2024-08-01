class ResetPasswordResponse {
  ResetPasswordResponse({
    required this.message,
    required this.phoneNumber,
    required this.resetToken,
  });

  final String message;
  final String phoneNumber;
  final String resetToken;

  // Фабричный конструктор для создания объекта из JSON
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      message: json['message'] as String,
      phoneNumber: json['phone_number'] as String,
      resetToken: json['resetToken'] as String,
    );
  }

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'phone_number': phoneNumber,
      'resetToken': resetToken,
    };
  }
}

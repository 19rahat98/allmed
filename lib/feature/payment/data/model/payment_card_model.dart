class PaymentCardModel {
  PaymentCardModel({
    required this.cardNumber,
    required this.cardDate,
    required this.cardCVC,
  });

  final String cardCVC;
  final String cardDate;
  final String cardNumber;
}

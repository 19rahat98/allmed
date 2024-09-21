import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/contants/global_pattern_constant.dart';
import 'package:allmed/common/contants/global_translate_constant.dart';
import 'package:allmed/generated/l10n.dart';
import 'package:intl/intl.dart';

/// Модель истории заказов, содержащая списки завершенных и активных заказов.
/// Модель истории заказов, содержащая объединенные списки завершенных и активных заказов.
class OrderHistoryModel {
  const OrderHistoryModel({
    this.orders = const [],
    this.inProgress = const [],
  });

  final List<OrderFetchInfo> orders;
  final List<OrderFetchInfo> inProgress;

  /// Фабричный метод для создания модели истории заказов из JSON.
  /// Парсит активные и завершенные заказы из JSON-объекта и объединяет списки с одинаковыми ключами.
  factory OrderHistoryModel.fromJsonList(Map<String, dynamic> json) {
    // Карта для хранения объединенных заказов с одинаковыми ключами
    List<OrderFetchInfo> activeOrderFetchList = [];
    Map<String, List<OrderModel>> combinedOrdersMap = {};

    // Парсинг активных заказов
    final inProgress = json['inProgress'] as Map<String, dynamic>?;
    inProgress?.forEach((key, value) {
      List<OrderModel> orderList = [];
      List<dynamic> inProgressOrders = value;
      for (var orderJson in inProgressOrders) {
        final order = OrderModel.fromJson(orderJson);
        orderList.add(order);
        combinedOrdersMap.update(
          key,
          (existingOrders) => existingOrders..add(order),
          ifAbsent: () => [order],
        );
        activeOrderFetchList.add(OrderFetchInfo(key, orderList));
      }
    });

    // Парсинг завершенных заказов
    final finished = json['completed'] as Map<String, dynamic>?;
    finished?.forEach((key, value) {
      List<dynamic> finishedOrders = value;
      for (var orderJson in finishedOrders) {
        final order = OrderModel.fromJson(orderJson);
        combinedOrdersMap.update(
          key,
          (existingOrders) => existingOrders..add(order),
          ifAbsent: () => [order],
        );
      }
    });

    // Преобразование карты в список
    List<OrderFetchInfo> orderFetchList =
        combinedOrdersMap.entries.map((entry) => OrderFetchInfo(entry.key, entry.value)).toList();

    return OrderHistoryModel(orders: orderFetchList, inProgress: activeOrderFetchList);
  }
}

class OrderModel {
  /// Конструктор модели заказа. Инициализирует все поля модели.
  OrderModel({
    this.id = GlobalCoreConstants.zeroInt,
    this.completed = GlobalCoreConstants.empty,
    this.serviceName = GlobalCoreConstants.empty,
    this.doctorName = GlobalCoreConstants.empty,
    this.doctorImage = GlobalCoreConstants.empty,
    this.day = GlobalCoreConstants.empty,
    this.createdAt = GlobalCoreConstants.empty,
    this.servicePrice = GlobalCoreConstants.empty,
    this.address = GlobalCoreConstants.empty,
    this.doctorRating = GlobalCoreConstants.empty,
    this.startTime = GlobalCoreConstants.empty,
    this.endTime = GlobalCoreConstants.empty,
    this.addressApartment,
    this.addressFloor,
    this.addressIntercom,
    this.addressEntrance,
  });

  final int id;
  final String doctorName;
  final String doctorImage;
  final String serviceName;
  final String day;
  final String createdAt;
  final String servicePrice;
  final String completed;
  final String doctorRating;
  final String address;
  final String? addressApartment;
  final String? addressFloor;
  final String? addressIntercom;
  final String? addressEntrance;
  final String startTime;
  final String endTime;

  /// Фабрика, создающая модель заказа из JSON.
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int? ?? GlobalCoreConstants.zeroInt,
      serviceName: json['service_name'] as String? ?? GlobalCoreConstants.empty,
      doctorName: json['doctor_name'] as String? ?? GlobalCoreConstants.empty,
      //doctorImage: json['doctor_iamge'] as String? ?? GlobalCoreConstants.empty,
      doctorImage: "https://be.cdn.alteg.io/images/no-master-sm.png",
      day: json['day'] as String? ?? GlobalCoreConstants.empty,
      createdAt: json['created_at'] as String? ?? GlobalCoreConstants.empty,
      servicePrice: json['service_price'] as String? ?? GlobalCoreConstants.empty,
      completed: json['completed'] as String? ?? GlobalCoreConstants.empty,
      address: json['address'] as String? ?? GlobalCoreConstants.empty,
      addressApartment: json['address_apartment'] as String?,
      addressFloor: json['address_floor'] as String?,
      addressIntercom: json['address_intercom'] as String?,
      addressEntrance: json['address_entrance'] as String?,
      doctorRating: json['doctor_rating'] as String? ?? GlobalCoreConstants.empty,
      startTime: json['start_time'] as String? ?? GlobalCoreConstants.empty,
      endTime: json['end_time'] as String? ?? GlobalCoreConstants.empty,
    );
  }

  /// Возвращает отформатированную дату в формате 'день месяц, день недели'
  String get formattedDay {
    final DateFormat formatter =
        DateFormat(GlobalDatePatternConstant.ddMMMMeeee, GlobalTranslateConstant.ru);
    return formatter.format(DateFormat(GlobalDatePatternConstant.yyyyMMddKM).parse(day));
  }

  /// Возвращает отформатированное время в формате 'ЧЧ:ММ'
  String get formattedTime {
    final DateFormat formatter = DateFormat(GlobalDatePatternConstant.hhdpmm);
    return formatter.format(DateTime.parse(createdAt));
  }

  /// Возвращает название услуги с маленькими буквами
  String get serviceTitle => serviceName.toLowerCase();

  /// Возвращает цену услуги с добавлением 'тг'
  String get price => '$servicePrice тг';

  /// Возвращает отформатированную дату и время создания заказа
  String get orderCreated {
    final DateTime dateTime = DateTime.parse(createdAt);
    final DateFormat formatter =
        DateFormat(GlobalDatePatternConstant.dMMMMyyyy, GlobalTranslateConstant.ru);
    return formatter.format(dateTime);
  }

  /// Возвращает день заказа
  /// Если заказ сделан сегодня, возвращает 'Сегодня'
  /// Иначе возвращает день недели на русском
  String get orderDay {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat(GlobalDatePatternConstant.ddMMyyyy);
    final todayDate = formatter.format(now);
    if (todayDate == day) {
      return S.current.today;
    }

    DateTime date = DateFormat(GlobalDatePatternConstant.ddMMyyyy).parse(day);

    // Форматирование даты в нужный формат 'день недели'
    return DateFormat(GlobalDatePatternConstant.week, GlobalTranslateConstant.ru).format(date);
  }

  /// Возвращает отформатированную строку, представляющую день и время заказа
  String get orderDate => '$orderDay, $startTime-$endTime';

  bool get isOrderCompleted => completed == 'Завершен';
}

/// Класс для хранения информации о заказах.
class OrderFetchInfo {
  final String orderDate;
  final List<OrderModel> orders;

  OrderFetchInfo(this.orderDate, this.orders);
}

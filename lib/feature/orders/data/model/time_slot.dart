import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:intl/intl.dart';

class TimeSlotResponse {
  final DoctorServiceModel data;
  final List<TimeSlotDto> times;

  const TimeSlotResponse({
    this.times = const [],
    this.data = const DoctorServiceModel(),
  });

  factory TimeSlotResponse.fromJson(Map<String, dynamic> json) {
    return TimeSlotResponse(
      data: DoctorServiceModel.fromJson(json['data']),
      times: List<TimeSlotDto>.from(json['times'].map((x) => TimeSlotDto.fromJson(x))),
    );
  }
}

class TimeSlotDto {
  final String time;
  final int sumLength;
  final int seanceLength;
  final DateTime? datetime;

  const TimeSlotDto({
    this.datetime,
    this.time = GlobalCoreConstants.empty,
    this.seanceLength = GlobalCoreConstants.zeroInt,
    this.sumLength = GlobalCoreConstants.zeroInt,
  });

  String get formatTime {
    // Парсинг времени из строки
    final parsedTime = DateFormat('H:mm').parse(time);

    // Проверка на формат времени
    if (time.length <= 5) {
      // Преобразование времени в формат с двумя цифрами для часа и минут
      return DateFormat('HH:mm').format(parsedTime);
    }

    // Если время уже в формате HH:mm, возвращаем его без изменений
    return time;
  }

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) {
    return TimeSlotDto(
      time: json['time'],
      seanceLength: json['seance_length'],
      sumLength: json['sum_length'],
      datetime: DateTime.parse(json['datetime']),
    );
  }
}

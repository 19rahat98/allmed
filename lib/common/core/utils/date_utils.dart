import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:intl/intl.dart';

/// Конвертируем дату из одного формата в другой
/// [currentDate] currentDate дата для которой требуеться конвертация
/// [currentDatePattern] в каком формате сейчас дата
/// [newDatePattern] в какой формат нужно перевести дату
String convertDate(
  String currentDate,
  String currentDatePattern,
  String newDatePattern, {
  bool toLocal = false,
}) {
  try {
    DateTime currentDateTime = DateTime.parse(currentDate);
    if (toLocal) {
      currentDateTime = currentDateTime.toLocal();
    }
    final newDateTime = DateFormat(newDatePattern).format(currentDateTime);
    return newDateTime;
  } catch (ex) {
    if (ex is FormatException) {
      var inputFormat = DateFormat(currentDatePattern);
      var currentDateTime = inputFormat.parse(currentDate);
      final newDateTime = DateFormat(newDatePattern).format(currentDateTime);
      return newDateTime;
    }
    return GlobalCoreConstants.empty;
  }
}

/// Высчитываем остаток времени из текущего и переданного в параметре время до окончания
/// [endDate] дата для высчитавания
String timeCalculate(String endDate) {
  DateTime currentDateTime = DateTime.now();
  final date = DateTime.parse(endDate).difference(currentDateTime);
  final hours = date.inHours.abs();
  final minutes = ((date.inSeconds / 60) % 60).floor().abs();
  final seconds = (date.inSeconds % 60).abs();

  final convertMinute = minutes.toString().length == 1 ? "0$minutes" : minutes;
  final convertSeconds = seconds.toString().length == 1 ? "0$seconds" : seconds;
  return "$hours:$convertMinute:$convertSeconds";
}

/// сравнивает промежуток двух времен с текущим временем по заданному `pattern`
/// и отдает флаг рабочее ли это время
bool compareTwoDate(String oneDate, String twoDate, String pattern) {
  try {
    DateTime oneDateDateTime = DateFormat(pattern).parse(oneDate);
    DateTime twoDateDateTime = DateFormat(pattern).parse(twoDate);
    DateTime currentDateTime = DateTime.now();

    final currentHour = currentDateTime.hour;
    final currentMinute = currentDateTime.minute;

    if (currentHour >= oneDateDateTime.hour &&
        currentHour <= twoDateDateTime.hour) {
      return true;
    }

    if (currentMinute >= oneDateDateTime.minute &&
        currentMinute <= twoDateDateTime.minute) {
      return true;
    }
  } catch (e) {
    return false;
  }

  return false;
}

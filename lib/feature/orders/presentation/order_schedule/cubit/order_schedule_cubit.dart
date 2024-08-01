import 'package:allmed/common/contants/global_core_constants.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_cubit.dart';
import 'package:allmed/common/core/presentation/abstract/bloc/core_state.dart';
import 'package:allmed/di/di_locator.dart';
import 'package:allmed/feature/doctor_service/data/model/doctor_dto.dart';
import 'package:allmed/feature/doctor_service/data/repository/doctor_service_repository.dart';
import 'package:allmed/feature/orders/data/model/time_slot.dart';
import 'package:intl/intl.dart';

part 'order_schedule_state.dart';

class OrderScheduleCubit extends CoreCubit {
  OrderScheduleCubit()
      : _repository = sl(),
        super(OrderScheduleInitial());

  final DoctorServiceRepository _repository;
  List<String> _dayList = [];
  int _serviceId = 0;
  int _addressId = 0;

  List<String> generateDateList(int daysCount) {
    List<String> dateList = [];
    DateTime currentDate = DateTime.now();
    DateFormat dateFormat = DateFormat('dd.MM');

    for (int i = 0; i < daysCount; i++) {
      dateList.add(dateFormat.format(currentDate.add(Duration(days: i))));
    }

    return dateList;
  }

  void changeSelectedDay(int id) {
    final state = _getCommonState();
    emit(
      state.copyWith(selectedDay: id, selectedSlot: GlobalCoreConstants.empty),
    );
    getTimeSlot(_dayList.elementAt(id));
  }

  void selectTimeSlot(String? slot) {
    final state = _getCommonState();
    emit(
      state.copyWith(selectedSlot: slot),
    );
    return;
  }

  void initCubit(int serviceId, int addressId) {
    _dayList = generateDateList(10);
    emit(
      OrderScheduleCommonState(
        selectedDay: 0,
        dayList: _dayList,
      ),
    );
    _addressId = addressId;
    _serviceId = serviceId;
    getTimeSlot(_dayList.first);
  }

  Future<void> getTimeSlot(String day) async {
    final state = _getCommonState();
    final request = _repository.showAvailableTimeSlot(
      _serviceId,
      _addressId,
      convertDateString(day),
    );

    await launch<TimeSlotResponse>(
      request: request,
      loading: (isLoading) => emit(
        state.copyWith(isLoading: isLoading),
      ),
      resultData: (result) => emit(
        state.copyWith(dayList: _dayList, timeSlot: result.times, serviceInfo: result.data),
      ),
    );
  }

  OrderScheduleCommonState _getCommonState() {
    if (state is OrderScheduleCommonState) {
      return state as OrderScheduleCommonState;
    }

    return OrderScheduleCommonState(dayList: _dayList);
  }
}

String convertDateString(String inputDate) {
  // Parse the input date string assuming it is for the current year
  final DateFormat inputFormat = DateFormat('dd.MM');
  DateTime date = inputFormat.parse(inputDate);

  // Add the year (2024)
  date = DateTime(DateTime.now().year, date.month, date.day);

  // Format the date to the desired output format
  final DateFormat outputFormat = DateFormat('yyyy-MM-dd');
  String outputDate = outputFormat.format(date);

  return outputDate;
}

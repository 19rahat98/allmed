part of 'order_schedule_cubit.dart';

class OrderScheduleInitial extends CoreState {}

class OrderScheduleCommonState extends CoreState {
  OrderScheduleCommonState({
    this.timeSlot,
    this.selectedSlot,
    this.selectedDay = 0,
    this.isLoading = false,
    this.dayList = const [],
    this.serviceInfo = const DoctorServiceModel(),
  });

  final int selectedDay;
  final bool isLoading;
  final List<String> dayList;
  final String? selectedSlot;
  final DoctorServiceModel serviceInfo;
  final List<TimeSlotDto>? timeSlot;

  String get selectedDate {
    final day = dayList.elementAt(selectedDay);
    return '${convertDateString(day)}T$selectedSlot';
  }

  String get callToDoctor {
    final day = dayList.elementAt(selectedDay);
    return '$day $selectedSlot';
  }

  OrderScheduleCommonState copyWith({
    bool? isLoading,
    int? selectedDay,
    String? selectedSlot,
    List<String>? dayList,
    List<TimeSlotDto>? timeSlot,
    DoctorServiceModel? serviceInfo,
  }) {
    return OrderScheduleCommonState(
      dayList: dayList ?? this.dayList,
      timeSlot: timeSlot ?? this.timeSlot,
      isLoading: isLoading ?? this.isLoading,
      serviceInfo: serviceInfo ?? this.serviceInfo,
      selectedDay: selectedDay ?? this.selectedDay,
      selectedSlot: selectedSlot ?? this.selectedSlot,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, dayList, timeSlot ?? 0, selectedDay, selectedSlot ?? 0, serviceInfo];
}

import 'package:exodus/data/models/schedule_model.dart';

abstract class ScheduleRepository {
  Future<Schedule> createSchedule({
    required List<ScheduleDetail> schedules,
    required String driverId,
    required String busId,
  });
}
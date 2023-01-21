import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final calendarController = ChangeNotifierProvider(
  (ref) => CalendarController(ref),
);

class CalendarController extends ChangeNotifier {
  CalendarController(this.ref);
  final Ref ref;

  CalendarFormat calendarFormat = CalendarFormat.month;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  ///
  /// 日付選択変更
  ///
  changeSelectedDay(DateTime chgSelectedDay, DateTime chgFocusedDay) {
    if (!isSameDay(selectedDay, chgSelectedDay)) {
      selectedDay = chgSelectedDay;
      focusedDay = chgFocusedDay;
      notifyListeners();
    }
  }

  ///
  /// カレンダーフォーマットの変更
  ///
  changeFormat(CalendarFormat chgFormat) {
    calendarFormat = chgFormat;
    notifyListeners();
  }

  ///
  /// フォーカス変更
  ///
  changeFocusedDay(DateTime chgFocusedDay) {
    focusedDay = chgFocusedDay;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final calendarProvider = ChangeNotifierProvider(
  (ref) => CalendarProvider(ref),
);

class CalendarProvider extends ChangeNotifier {
  CalendarProvider(this.ref);
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

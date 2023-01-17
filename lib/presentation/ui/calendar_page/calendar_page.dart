import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keiba/presentation/ui/calendar_page/custom_calendar_builders.dart';
// import 'package:keiba/presentation/ui/home_page/home_page_utils.dart';
import 'package:keiba/presentation/ui/calendar_page/provider/calendar_page_provider.dart';
import 'package:keiba/presentation/ui/setting_page/setting_page.dart';
import 'package:table_calendar/table_calendar.dart';

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: BodyWidget(),
    );
  }
}

///
/// calenderページのAppBar設定
///
class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return AppBar(
          elevation: 0.0, // 境界線を消す
          // 右側ボタン（設定画面遷移アイコン）
          actions: [_settingIcon(context)],
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  ///
  /// 設定画面遷移アイコン
  ///
  Widget _settingIcon(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return const SettingPage();
          }),
        );
      },
      icon: const Icon(Icons.settings, size: 25),
    );
  }
}

///
/// calendarページのbody部
///
class BodyWidget extends ConsumerWidget {
  // final CalendarFormat _calendarFormat = CalendarFormat.month;

  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(calendarPageProvider);
    final CustomCalendarBuilders customCalendarBuilders = CustomCalendarBuilders();

    return SizedBox(
      child: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: provider.focusedDay,
        calendarFormat: provider.calendarFormat,
        // shouldFillViewport: true, // カレンダーの大きさ変更可
        locale: 'ja_JP',
        rowHeight: 70,
        daysOfWeekHeight: 32,
        calendarStyle: const CalendarStyle(
          // true（デフォルト）の場合はtodayBuilderが呼ばれるため設定する
          isTodayHighlighted: false,
        ),
        // カスタマイズ用の関数
        calendarBuilders: CalendarBuilders(
          dowBuilder: customCalendarBuilders.daysOfWeekBuilder,
          defaultBuilder: customCalendarBuilders.defaultBuilder,
          disabledBuilder: customCalendarBuilders.disabledBuilder,
          selectedBuilder: customCalendarBuilders.selectedBuilder,
        ),
        selectedDayPredicate: (day) {
          return isSameDay(provider.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          provider.changeSelectedDay(selectedDay, focusedDay);
        },
        onFormatChanged: (format) {
          if (provider.calendarFormat != format) {
            provider.changeFormat(format);
          }
        },
        onPageChanged: (focusedDay) {
          provider.changeFocusedDay(focusedDay);
        },
      ),
    );
  }
}

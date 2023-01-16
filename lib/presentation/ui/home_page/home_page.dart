import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keiba/presentation/ui/home_page/home_page_utils.dart';
import 'package:keiba/presentation/ui/home_page/provider/home_page_provider.dart';
import 'package:keiba/presentation/ui/setting_page/setting_page.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      body: BodyWidget(),
    );
  }
}

///
/// homeページのAppBar設定
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
/// homeページのbody部
///
class BodyWidget extends ConsumerWidget {
  // final CalendarFormat _calendarFormat = CalendarFormat.month;

  const BodyWidget({super.key});

  // カレンダーの文字色設定
  Color _textColor(DateTime day) {
    const defaultTextColor = Colors.black87;

    if (day.weekday == DateTime.sunday) {
      return Colors.red;
    }
    if (day.weekday == DateTime.saturday) {
      return Colors.blue[600]!;
    }
    return defaultTextColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homePageP = ref.watch(homePageProvider);

    return SizedBox(
      child: TableCalendar(
        firstDay: kFirstDay,
        lastDay: kLastDay,
        focusedDay: homePageP.focusedDay,
        calendarFormat: homePageP.calendarFormat,
        // shouldFillViewport: true, // カレンダーの大きさ変更可
        locale: 'ja_JP',
        selectedDayPredicate: (day) {
          return isSameDay(homePageP.selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(homePageP.selectedDay, selectedDay)) {
            homePageP.changeSelectedDay(selectedDay, focusedDay);
          }
        },
        onFormatChanged: (format) {
          if (homePageP.calendarFormat != format) {
            homePageP.changeFormat(format);
          }
        },
        onPageChanged: (focusedDay) {
          homePageP.changeFocusedDay(focusedDay);
        },
        // calendarBuilders: CalendarBuilders(
        //   dowBuilder: (BuildContext context, DateTime day) {
        //     // アプリの言語設定読み込み<TableCalendarの中身からコピー>
        //     final locale = Localizations.localeOf(context).languageCode;

        //     // アプリの言語設定に曜日の文字を対応させる
        //     final dowText = const DaysOfWeekStyle().dowTextFormatter?.call(day, locale) ??
        //         DateFormat.E(locale).format(day);
        //     return Center(
        //       child: Text(
        //         dowText,
        //         // style: TextStyle(color: _textColor(day)),
        //       ),
        //     );
        //   },
        //   defaultBuilder: (context, day, focusedDay) {
        //     return AnimatedContainer(
        //       duration: const Duration(milliseconds: 250),
        //       margin: EdgeInsets.zero,
        //       alignment: Alignment.topCenter,
        //       child: Text(
        //         day.day.toString(),
        //         style: TextStyle(color: _textColor(day)),
        //       ),
        //     );
        //   },
        //   // 有効範囲（firstDay~lastDay）以外の日付部分を生成する
        //   disabledBuilder: (BuildContext context, DateTime day, DateTime focusedDay) {
        //     return AnimatedContainer(
        //       duration: const Duration(milliseconds: 250),
        //       margin: EdgeInsets.zero,
        //       alignment: Alignment.topCenter,
        //       child: Text(
        //         day.day.toString(),
        //         style: const TextStyle(color: Colors.grey),
        //       ),
        //     );
        //   },
        //   selectedBuilder: (context, day, focusedDay) {
        //     return AnimatedContainer(
        //       duration: const Duration(milliseconds: 250),
        //       alignment: Alignment.topCenter,
        //       child: Text(
        //         day.day.toString(),
        //         style: const TextStyle(
        //           color: Colors.black87,
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ),
    );
  }
}

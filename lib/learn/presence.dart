import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Shift { shift1, shift2, shift3 }

class SimplePresence extends StatefulWidget {
  const SimplePresence({super.key});

  @override
  State<SimplePresence> createState() => _SimplePresenceState();
}

class _SimplePresenceState extends State<SimplePresence> {
  String? clockInTime;
  String? clockOutTime;
  Shift? currentShift;

  Shift? determineShift(int weeks) {
    switch (weeks) {
      case 1:
      case 4:
        return Shift.shift1;
      case 2:
        return Shift.shift2;
      case 3:
        return Shift.shift3;
      default:
        return null;
    }
  }

  DateTime? dateTimeNow;

  void clockIn() {
    // MENDAPATKAN MINGGU KE BERAPA
    int weekNumber =
        ((dateTimeNow!.day - dateTimeNow!.weekday + 10) / 7).floor();

    setState(() {
      currentShift = determineShift(weekNumber);
      clockInTime = DateFormat.Hms().format(DateTime.now());
    });
  }

  void clockOut() {
    setState(() {
      clockOutTime = DateFormat.Hms().format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    dateTimeNow = DateTime(2024, 3, 11);
    final format = DateFormat('EEEE, d MM yyyy');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Simple Presence"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Current Shift: ${format.format(dateTimeNow!)}\n${currentShift ?? ""}",
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  clockIn();
                },
                child: const Text("Clock In"),
              ),
              const SizedBox(
                height: 5,
              ),
              if (clockInTime != null) Text("Clock In: $clockInTime "),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => clockOut(),
                child: const Text("Clock Out"),
              ),
              const SizedBox(
                height: 5,
              ),
              if (clockOutTime != null) Text("Time: $clockOutTime"),
            ],
          ),
        ),
      ),
    );
  }
}

/*


  int weeksCountOfWeekday(int weekdayToCnt, int month, int year) {
    print("WEEKDAY COUNT: $weekdayToCnt - MOUNTH: $month - YEAR: $year");

    assert(weekdayToCnt >= 1 && weekdayToCnt <= 7);

    final DateTime startDate = DateTime(year, month);
    final DateTime endDate =
        DateTime(year, month + 1).subtract(const Duration(days: 1));

    print("END DAT: $endDate");

    int res = 1;
    int dayOfWeekday;

    if (weekdayToCnt < startDate.weekday) {
      dayOfWeekday = startDate.day + 7 - (startDate.weekday - weekdayToCnt);
    } else {
      dayOfWeekday = 1 + weekdayToCnt - startDate.weekday;
    }

    while (dayOfWeekday + 7 <= endDate.day) {
      res++;
      dayOfWeekday += 7;
    }

    return res;
  }

  DateTime mostRecentSunday(DateTime date) {
    print("WEEKKKDAY ${date.weekday} - ${date.day}");
    return DateTime(date.year, date.month, date.day - date.weekday % 7);
  }

  DateTime mostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));

  DateTime mostRecentWeekday(DateTime date, int weekday) =>
      DateTime(date.year, date.month, date.day - (date.weekday - weekday) % 7);

  DateTime mostRecentMonday(DateTime date) =>
      DateTime(date.year, date.month, date.day - (date.weekday - 1));
*/
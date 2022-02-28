/*
// PubDev helper package: https://pub.dev/packages/shamsi_date

import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../mfw_prints.dart';

// --------------------------------------------------------------------------------------------------------------------

// Basics:

class FCTCalendar {
  int year;
  List<FCTMonth> months = [];

  FCTCalendar(this.year) {
    for (int monthNumber = 1; monthNumber <= 12; monthNumber++) {
      months.add(
        FCTMonth(
          year: year,
          monthNumber: monthNumber,
          monthName: getMonthName(monthNumber),
          monthLength: Jalali(year, monthNumber).monthLength,
        ),
      );
    }
  }
}

class FCTMonth {
  int year;
  int monthNumber;
  String monthName;
  int monthLength;
  List<Jalali> days = [];

  FCTMonth({required this.year, required this.monthNumber, required this.monthName, required this.monthLength}) {
    for (int day = 1; day <= monthLength; day++) {
      days.add(Jalali(year, monthNumber, day));
    }
  }
}

String getMonthName(int monthNumber) {
  switch (monthNumber) {
    case 1:
      return "فروردین";
    case 2:
      return "اردیبهشت";
    case 3:
      return "خرداد";
    case 4:
      return "تیر";
    case 5:
      return "مرداد";
    case 6:
      return "شهریور";
    case 7:
      return "مهر";
    case 8:
      return "آبان";
    case 9:
      return "آذر";
    case 10:
      return "دی";
    case 11:
      return "بهمن";
    case 12:
      return "اسفند";
    default:
      throw DateException("عدد ماه نامعتبر است");
  }
}

int getMonthNumber(String monthName) {
  switch (monthName) {
    case "فروردین":
      return 1;
    case "اردیبهشت":
      return 2;
    case "خرداد":
      return 3;
    case "تیر":
      return 4;
    case "مرداد":
      return 5;
    case "شهریور":
      return 6;
    case "مهر":
      return 7;
    case "آبان":
      return 8;
    case "آذر":
      return 9;
    case "دی":
      return 10;
    case "بهمن":
      return 11;
    case "اسفند":
      return 12;
    default:
      throw DateException("ماه نامعتبر است");
  }
}

String getWeekDayName(int weekDayNumber) {
  switch (weekDayNumber) {
    case 1:
      return "شنبه";
    case 2:
      return "یکشنبه";
    case 3:
      return "دوشنبه";
    case 4:
      return "سه" "\u200c" "شنبه";
    case 5:
      return "چهارشنبه";
    case 6:
      return "پنج" "\u200c" "شنبه";
    case 7:
      return "جمعه";
    default:
      throw DateException("عدد روز هفته نامعتبر است");
  }
}

int getWeekDayNumber(String weekDayName) {
  switch (weekDayName) {
    case "شنبه":
      return 1;
    case "یکشنبه":
      return 2;
    case "دوشنبه":
      return 3;
    case "دو شنبه":
      return 3;
    case "سه" "\u200c" "شنبه":
      return 4;
    case "سه شنبه":
      return 4;
    case "چهارشنبه":
      return 5;
    case "چهار شنبه":
      return 5;
    case "پنج" "\u200c" "شنبه":
      return 6;
    case "پنج شنبه":
      return 6;
    case "جمعه":
      return 7;
    default:
      throw DateException("نام روز هفته نامعتبر است");
  }
}

// --------------------------------------------------------------------------------------------------------------------

// FCT main date picker:

const Color fctMainDatePickerPurpleColor = Color(0xff254fbf);
const Color fctMainDatePickerRedColor = Color(0xffff2938);

class FCTMainDatePicker extends StatefulWidget {
  const FCTMainDatePicker({Key? key}) : super(key: key);

  @override
  _FCTMainDatePickerState createState() => _FCTMainDatePickerState();
}

class _FCTMainDatePickerState extends State<FCTMainDatePicker> {
  late Jalali now;
  late int minYear;
  late int maxYear;
  List<FCTMonth> allMonths = [];
  late PageController pageController;
  late Jalali selectedJalaliDay;

  @override
  void initState() {
    super.initState();
    now = Jalali.now();
    minYear = now.year - 10;
    maxYear = now.year + 10;
    for (int year = minYear; year <= maxYear; year++) {
      allMonths.addAll(FCTCalendar(year).months);
    }
    pageController = PageController(initialPage: 120 + (now.month - 1));
    selectedJalaliDay = now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              body(),
              const Divider(
                thickness: 1,
                color: Colors.black26,
              ),
              footerButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget body() {
    return SizedBox(
      height: 610,
      child: PageView.builder(
        controller: pageController,
        itemCount: allMonths.length,
        itemBuilder: (context, pageIndex) {
          FCTMonth pageMonth = allMonths[pageIndex];
          try {
            selectedJalaliDay = pageMonth.days[selectedJalaliDay.day - 1];
          } on RangeError catch (e) {
            mPrintRed(e);
            selectedJalaliDay = pageMonth.days[0];
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              headerOfBody(pageMonth),
              bodyOfBody(pageMonth),
            ],
          );
        },
      ),
    );
  }

  Widget headerOfBody(FCTMonth pageMonth) {
    return Container(
      color: fctMainDatePickerPurpleColor,
      height: 160,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  getWeekDayName(selectedJalaliDay.weekDay),
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 45,
                    backgroundColor: fctMainDatePickerPurpleColor,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Center(
                        child: Text(
                          selectedJalaliDay.day.toString(),
                          style: const TextStyle(color: fctMainDatePickerPurpleColor, fontSize: 35, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text(
                  "${pageMonth.monthName} ${pageMonth.year}",
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bodyOfBody(FCTMonth pageMonth) {
    return SizedBox(
      width: 400,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 7,
        shrinkWrap: true,
        children: [
          for (Widget weekName in initWeekNames()) weekName,
          for (int count = 0; count < (pageMonth.days[0].weekDay - 1); count++) const SizedBox(),
          for (Jalali day in pageMonth.days) initDays(day),
        ],
      ),
    );
  }

  List<Widget> initWeekNames() {
    return [
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("شنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("یکشنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("دوشنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("سه" "\u200c" "شنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("چهارشنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("پنج" "\u200c" "شنبه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
      const Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text("جمعه", style: TextStyle(color: Colors.grey, fontSize: 12)),
        ),
      ),
    ];
  }

  Widget initDays(Jalali jalaliDay) {
    if (jalaliDay.day == selectedJalaliDay.day) {
      return TextButton(
        child: CircleAvatar(
          backgroundColor: fctMainDatePickerRedColor,
          child: Text(
            jalaliDay.day.toString(),
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600, textBaseline: TextBaseline.alphabetic),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedJalaliDay = jalaliDay;
          });
        },
      );
    }
    return TextButton(
      child: Text(
        jalaliDay.day.toString(),
        style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600, textBaseline: TextBaseline.alphabetic),
      ),
      onPressed: () {
        setState(() {
          selectedJalaliDay = jalaliDay;
        });
      },
    );
  }

  Widget footerButtons() {
    return SizedBox(
      height: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: fctMainDatePickerPurpleColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                ),
                child: const Text(
                  "امروز",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                onPressed: () {
                  goToNow();
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.done, size: 30, color: Colors.green),
              onPressed: () {
                Navigator.pop<Jalali>(context, selectedJalaliDay);
              },
            ),
            IconButton(
              icon: const Icon(Icons.cancel_sharp, size: 25, color: Colors.grey),
              onPressed: () {
                Navigator.pop<Jalali?>(context, null);
              },
            ),
          ],
        ),
      ),
    );
  }

  void goToNow() {
    setState(() {
      pageController.jumpToPage(120 + (now.month - 1));
      selectedJalaliDay = now;
    });
  }
}

Future<Jalali?> mShowFCTMainDatePicker(BuildContext context) async {
  Jalali? selectedDate = await Navigator.of(context).push<Jalali?>(
    MaterialPageRoute(
      builder: (context) {
        return const FCTMainDatePicker();
      },
    ),
  );
  return selectedDate;
}

// --------------------------------------------------------------------------------------------------------------------

// FCT dialog date picker:

// --------------------------------------------------------------------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:vocablury/global.dart';
import 'package:vocablury/utilities/packages/smooth_rectangular_border.dart';

class SingleCalender extends StatefulWidget {
  const SingleCalender({Key? key}) : super(key: key);

  @override
  SingleCalenderState createState() => SingleCalenderState();
}

class SingleCalenderState extends State<SingleCalender> {
  DateTime _selectedMonth = DateTime.now();
  DateTime? selectedDate;

  List<DateTime> getDisplayDates(DateTime currentDate) {
    final firstDateOfMonth = DateTime(currentDate.year, currentDate.month, 1);
    final lastDateOfMonth = DateTime(currentDate.year, currentDate.month + 1, 0);

    DateTime firstDisplayDate = firstDateOfMonth;
    DateTime lastDisplayDate = lastDateOfMonth;

    DateTime indexDate = firstDisplayDate;

    while (indexDate.weekday != DateTime.sunday) {
      indexDate = indexDate.subtract(const Duration(days: 1));
    }
    firstDisplayDate = indexDate;

    indexDate = lastDisplayDate;
    while (indexDate.weekday != DateTime.saturday) {
      indexDate = indexDate.add(const Duration(days: 1));
    }
    lastDisplayDate = indexDate.add(const Duration(days: 1));

    List<DateTime> dates = [];

    indexDate = firstDisplayDate;
    while (indexDate.isBefore(lastDisplayDate)) {
      dates.add(indexDate);

      indexDate = indexDate.add(const Duration(days: 1));
    }

    return dates;
  }

  void changeMonth(int index) {
    setState(() {
      final previousMonth = _selectedMonth;
      _selectedMonth = DateTime(_selectedMonth.year, _selectedMonth.month + index);
      if (index == 0) {
        _selectedMonth = DateTime.now();
        return;
      }
      if (index != 0) {
        if (_selectedMonth.isAfter(previousMonth)) {
        } else if (_selectedMonth.isBefore(previousMonth)) {}
      }
      getDisplayDates(_selectedMonth);
    });
  }

  bool isToday(DateTime date) {
    DateTime now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }

  String getMonthName(month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "Invalid month number";
    }
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${getMonthName(_selectedMonth.month)} ${_selectedMonth.year}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
        ),
        Row(
          children: [
            Text(
              'View',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: GlobalColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 12),
            const Icon(
              Icons.arrow_forward_ios,
              color: GlobalColors.primaryColor,
              size: 16,
            )
          ],
        ),
      ],
    );
  }

  Widget _buildWeeks() {
    List<String> weeks = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    return Row(
      children: List.generate(
        weeks.length,
        (index) {
          final day = weeks[index];
          return Flexible(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                day,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = getDisplayDates(_selectedMonth);

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: GlobalColors.borderColor,
        borderRadius: SmoothBorderRadius(cornerRadius: 16),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        children: [
          _buildCalendarHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Divider(
              color: Colors.grey.withOpacity(0.2),
              thickness: 1,
            ),
          ),
          Column(
            children: [
              _buildWeeks(),
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisExtent: 40,
                ),
                itemCount: daysInMonth.length,
                itemBuilder: (context, index) {
                  final day = daysInMonth[index];
                  final isEmptyDate = day.month != _selectedMonth.month;
                  return GestureDetector(
                    onTap: isEmptyDate
                        ? null
                        : () {
                            setState(() {
                              _selectedMonth = day;
                            });
                          },
                    child: AnimatedContainer(
                      curve: Curves.easeInOutQuint,
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                      padding: const EdgeInsets.only(top: 6),
                      decoration: BoxDecoration(
                        borderRadius: SmoothBorderRadius(cornerRadius: 26),
                        color: day.day == _selectedMonth.day && day.month == _selectedMonth.month
                            ? GlobalColors.primaryColor
                            : null,
                      ),
                      duration: const Duration(milliseconds: 400),
                      child: Text(
                        isEmptyDate ? " " : day.day.toString(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color:
                                  day.day == _selectedMonth.day && day.month == _selectedMonth.month
                                      ? Colors.white
                                      : null,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controller/TaskController.dart';

class MovingCalendar extends StatefulWidget {
  const MovingCalendar({super.key});

  @override
  State<MovingCalendar> createState() => _MovingCalendarState();
}

class _MovingCalendarState extends State<MovingCalendar> {
  // These variables track the 'movement' and selection
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Calendar')),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,

        // This is what allows the 'swipe' movement
        availableGestures: AvailableGestures.all,

        // Updates which day is highlighted when you tap
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },

        // Updates the view when you swipe to a new month
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },

        // Aesthetic styling
        calendarStyle: const CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Colors.deepPurple,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_x/get.dart';
import '../contollers/TaskController.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final TaskController taskController = Get.find<TaskController>();
  final TextEditingController textController = TextEditingController();

  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now();

  DateTime get _firstDayOfMonth =>
      DateTime(_focusedMonth.year, _focusedMonth.month, 1);

  int get _daysInMonth =>
      DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;

  int get _startWeekday => _firstDayOfMonth.weekday % 7;

  void _previousMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  bool _isToday(DateTime date) => _isSameDay(date, DateTime.now());

  String _monthName(int month) {
    const names = [
      '',
      'JANUARY',
      'FEBRUARY',
      'MARCH',
      'APRIL',
      'MAY',
      'JUNE',
      'JULY',
      'AUGUST',
      'SEPTEMBER',
      'OCTOBER',
      'NOVEMBER',
      'DECEMBER',
    ];
    return names[month];
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add Task', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
              '${_selectedDate.day} ${_monthName(_selectedDate.month)} ${_selectedDate.year}',
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
            ),
          ],
        ),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Type task here...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.green[700]!),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              textController.clear();
              Navigator.pop(context);
            },
            child: Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.trim().isNotEmpty) {
                taskController.addTask(
                  textController.text.trim(),
                  date: _selectedDate,
                );
                textController.clear();
                Navigator.pop(context);
                setState(() {}); // Refresh dot indicators
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Task'),
        content: Text('Remove this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              taskController.deleteTaskForDate(_selectedDate, index);
              Navigator.pop(context);
              setState(() {});
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF3FB),
      body: SafeArea(
        child: Column(
          children: [
            _buildCalendarCard(),
            const SizedBox(height: 8),
            _buildTaskList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        backgroundColor: const Color(0xFF7BA7D4),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 2)),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _buildMonthHeader(),
          const SizedBox(height: 10),
          _buildWeekdayLabels(),
          const SizedBox(height: 6),
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.chevron_left, color: Colors.grey[600]),
          onPressed: _previousMonth,
        ),
        Text(
          '${_monthName(_focusedMonth.month)}  ${_focusedMonth.year}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
            letterSpacing: 1.2,
          ),
        ),
        IconButton(
          icon: Icon(Icons.chevron_right, color: Colors.grey[600]),
          onPressed: _nextMonth,
        ),
      ],
    );
  }

  Widget _buildWeekdayLabels() {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    final totalCells = _startWeekday + _daysInMonth;
    final rows = (totalCells / 7).ceil();

    return Column(
      children: List.generate(rows, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final dayNumber = cellIndex - _startWeekday + 1;

            if (dayNumber < 1 || dayNumber > _daysInMonth) {
              return Expanded(child: SizedBox(height: 44));
            }

            final date = DateTime(
              _focusedMonth.year,
              _focusedMonth.month,
              dayNumber,
            );
            final isSelected = _isSameDay(date, _selectedDate);
            final isToday = _isToday(date);
            final hasTasks = taskController.hasTasksOnDate(date);

            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedDate = date),
                child: Container(
                  height: 44,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF7BA7D4)
                        : isToday
                        ? const Color(0xFFD6E9F8)
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$dayNumber',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected || isToday
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isSelected ? Colors.white : Colors.grey[800],
                        ),
                      ),
                      if (hasTasks)
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white
                                : const Color(0xFF7BA7D4),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: Obx(() {
        final tasks = taskController.getTasksForDate(_selectedDate);

        if (tasks.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_note, size: 48, color: Colors.grey[300]),
                const SizedBox(height: 8),
                Text(
                  'No tasks for this day',
                  style: TextStyle(color: Colors.grey[400], fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tap + to add one',
                  style: TextStyle(color: Colors.grey[300], fontSize: 13),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border(
                  left: BorderSide(color: const Color(0xFF7BA7D4), width: 4),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  tasks[index],
                  style: TextStyle(fontSize: 15, color: Colors.grey[800]),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flag_outlined,
                      color: Colors.grey[400],
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Colors.red[300],
                        size: 20,
                      ),
                      onPressed: () => _showDeleteDialog(index),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

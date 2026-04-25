import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/TaskController.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find<TaskController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: Obx(() {
        final allTasksList = taskController.tasks;
        final total = allTasksList.length;
        final active = allTasksList.where((t) => !t.isCompleted).length;
        final done = allTasksList.where((t) => t.isCompleted).length;

        // ✅ Calculate progress directly here
        final progressValue = total == 0 ? 0.0 : done / total;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  bottom: 32,
                  left: 24,
                  right: 24,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1E2A38), const Color(0xFF263545)]
                        : [const Color(0xFF546E7A), const Color(0xFF78909C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(36),
                  ),
                ),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 36,
                      backgroundColor: Colors.white24,
                      child: Text(
                        "TM",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Task Manager User",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: progressValue,
                      backgroundColor: Colors.white24,
                      color: Colors.cyanAccent,
                      minHeight: 8,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${(progressValue * 100).toInt()}% Done",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
                child: Row(
                  children: [
                    _StatCard(
                      label: "Total".tr,
                      value: total,
                      icon: Icons.task_alt,
                      color: const Color(0xFF546E7A),
                    ),
                    const SizedBox(width: 10),
                    _StatCard(
                      label: "Active".tr,
                      value: active,
                      icon: Icons.pending_actions,
                      color: const Color(0xFFF59E0B),
                    ),
                    const SizedBox(width: 10),
                    _StatCard(
                      label: "Done".tr,
                      value: done,
                      icon: Icons.check_circle_outline,
                      color: const Color(0xFF22C55E),
                    ),
                  ],
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Text(
                  "Recent Tasks",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            allTasksList.isEmpty
                ? const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(40),
                      child: Center(child: Text("No tasks yet")),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final task = allTasksList[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 4,
                        ),
                        child: ListTile(
                          leading: Icon(
                            task.isCompleted
                                ? Icons.check_circle
                                : Icons.circle_outlined,
                            color: task.isCompleted
                                ? Colors.green
                                : Colors.grey,
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          // ✅ Show due date instead of description (which doesn't exist)
                          subtitle: Text(
                            task.dueDate != null
                                ? task.dueDate.toString().split(' ')[0]
                                : "No due date",
                          ),
                        ),
                      );
                    }, childCount: total),
                  ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 30)),
          ],
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(
              value.toString(),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

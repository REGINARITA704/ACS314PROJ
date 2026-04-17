import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/TaskController.dart';
import 'package:flutter_application_1/controller/ThemeController.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ThemeController themeController = Get.find();
  final TaskController taskController = Get.find();

  bool notificationsEnabled = true;
  bool isEditing = false;
  String selectedLanguage = "English";

  final usernameController = TextEditingController(text: "regina_admin");
  final emailController = TextEditingController(text: "regina@university.edu");

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => isEditing = !isEditing),
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit_note,
              size: 20,
            ),
            label: Text(isEditing ? "Save" : "Edit"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionLabel("Profile"),
            _editableTile(Icons.person_outline, "Username", usernameController),
            _editableTile(Icons.email_outlined, "Email", emailController),
            _passwordTile(),

            const SizedBox(height: 24),

            _sectionLabel("Appearance"),
            Obx(
              () => _switchTile(
                icon: themeController.isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
                title: "Dark Mode",
                subtitle: themeController.isDark
                    ? "Dark theme is on"
                    : "Light theme is on",
                value: themeController.isDark,
                onChanged: (_) => themeController.toggleTheme(),
                activeColor: const Color(0xFF546E7A),
              ),
            ),

            const SizedBox(height: 24),

            _sectionLabel("Notifications"),
            _switchTile(
              icon: Icons.notifications_outlined,
              title: "Push Notifications",
              subtitle: notificationsEnabled
                  ? "You'll receive task reminders"
                  : "Notifications are off",
              value: notificationsEnabled,
              onChanged: (v) => setState(() => notificationsEnabled = v),
              activeColor: const Color(0xFF22C55E),
            ),

            const SizedBox(height: 24),

            _sectionLabel("Preferences"),
            _languageTile(),
            _actionTile(
              icon: Icons.delete_sweep_outlined,
              title: "Clear All Tasks",
              subtitle: "Remove all tasks permanently",
              color: Colors.redAccent,
              onTap: () => _confirmClearTasks(context),
            ),

            const SizedBox(height: 24),

            _sectionLabel("About"),
            _infoTile(Icons.info_outline, "App Version", "1.0.0"),
            _infoTile(Icons.code, "Built with", "Flutter + GetX"),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Colors.grey[500],
        letterSpacing: 1.2,
      ),
    ),
  );

  Widget _editableTile(
    IconData icon,
    String label,
    TextEditingController ctrl,
  ) {
    return _card(
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF546E7A), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                isEditing
                    ? TextField(
                        controller: ctrl,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: const InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      )
                    : Text(
                        ctrl.text,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ],
            ),
          ),
          if (isEditing) const Icon(Icons.edit, size: 16, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _passwordTile() {
    return _card(
      child: Row(
        children: [
          const Icon(Icons.lock_outline, color: Color(0xFF546E7A), size: 22),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  "••••••••",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              "Change",
              style: TextStyle(color: Color(0xFF546E7A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required Color activeColor,
  }) {
    return _card(
      child: Row(
        children: [
          Icon(icon, color: activeColor, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Switch(value: value, onChanged: onChanged, activeColor: activeColor),
        ],
      ),
    );
  }

  Widget _languageTile() {
    return _card(
      child: Row(
        children: [
          const Icon(Icons.language, color: Color(0xFF546E7A), size: 22),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Language",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text(
                  "Select your language",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: selectedLanguage,
            underline: const SizedBox(),
            items: [
              "English",
              "Swahili",
              "French",
            ].map((l) => DropdownMenuItem(value: l, child: Text(l))).toList(),
            onChanged: (v) => setState(() => selectedLanguage = v!),
          ),
        ],
      ),
    );
  }

  Widget _actionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return _card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: color,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _infoTile(IconData icon, String title, String value) {
    return _card(
      child: Row(
        children: [
          Icon(icon, color: Colors.grey, size: 22),
          const SizedBox(width: 14),
          Text(title, style: const TextStyle(fontSize: 15)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 13, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  void _confirmClearTasks(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Clear All Tasks"),
        content: const Text(
          "Are you sure you want to delete all tasks? This cannot be undone.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              taskController.clearAllTasks();
              Navigator.pop(context);
            },
            child: const Text("Clear", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

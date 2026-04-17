import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      appBar: AppBar(
        title: const Text(
          "Account Settings",
          style: TextStyle(color: Color(0xFF4A4E69)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.check_circle : Icons.edit_note,
              color: const Color(0xFF9B5DE5),
              size: 30,
            ),
            onPressed: () => setState(() => isEditing = !isEditing),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            _tile(Icons.person_outline, "Username", "regina_admin"),
            _tile(Icons.lock_outline, "Password", "••••••••"),
            _tile(Icons.email_outlined, "Email", "regina@university.edu"),
            const SizedBox(height: 20),
            _toggleTile(
              Icons.notifications_active_outlined,
              "Push Notifications",
            ),
            _toggleTile(Icons.dark_mode_outlined, "Dark Appearance"),
            if (isEditing)
              Padding(
                padding: const EdgeInsets.all(40),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF9B5DE5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () => setState(() => isEditing = false),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tile(IconData i, String t, String v) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(i, color: const Color(0xFFFF99C8)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              isEditing
                  ? SizedBox(
                      width: 150,
                      height: 30,
                      child: TextField(
                        decoration: InputDecoration(hintText: v),
                      ),
                    )
                  : Text(
                      v,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleTile(IconData i, String t) {
    return ListTile(
      leading: Icon(i, color: const Color(0xFF9B5DE5)),
      title: Text(t),
      trailing: Switch(
        value: true,
        activeColor: const Color(0xFFFF99C8),
        onChanged: (v) {},
      ),
    );
  }
}

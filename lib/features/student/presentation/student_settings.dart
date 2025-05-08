import 'package:flutter/material.dart';

class StudentSettings extends StatefulWidget {
  const StudentSettings({super.key});

  @override
  State<StudentSettings> createState() => _StudentSettingsState();
}

class _StudentSettingsState extends State<StudentSettings> {
  bool langVal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Choose Language",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("EN"),
                    Switch(
                      value: langVal,
                      onChanged: (val) {
                        setState(() {
                          langVal = val;
                        });
                      },
                    ),
                    Text("AR"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

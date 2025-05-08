import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hands_test/features/interpreter/controller/interpreter_viewmodel.dart';

class InterpreterProfile extends GetWidget<InterpreterViewModel> {
  const InterpreterProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Profile Picture
            const CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/HandsInWordsLogo.png"),
              // child: Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 15),

            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.blueAccent,
              ),
              title: Text(
                controller.interpreterData!.fullName!,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ), // Example phone number
            ),
            ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.blueAccent,
              ),
              title: Text(
                "${controller.interpreterData!.email}",
              ), // Example location
            ),
            const ListTile(
              leading: Icon(
                Icons.language,
                color: Colors.blueAccent,
              ),
              title: Text(
                "Arabic, English",
              ), // Example languages
            ),
            const Spacer(),
            // Edit Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.signOut();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.red,
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

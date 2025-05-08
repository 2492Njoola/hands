import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hands_test/core/utils/constants.dart';
import 'package:hands_test/features/interpreter/controller/interpreter_viewmodel.dart';
import 'package:hands_test/features/interpreter/presentation/call_screen.dart';
import 'package:hands_test/model/interpreter.dart';

class InterpreterScreen extends GetWidget<InterpreterViewModel> {
  const InterpreterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Calls")
            .where("interpreter_id", isEqualTo: AppConstants.userId)
            .where("request", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Get.defaultDialog(
              title: "Video Call",
              content: Text("Request to call"),
              onConfirm: () {
                // FirebaseFirestore.instance.collection("Calls").
              },
              onCancel: () {},
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/images/HandsInWordsLogo.png",
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello, ",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          controller.interpreterData!.fullName!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF236868),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 44),
                const InterpreterStreamWidget(),
              ],
            ),
          );
        });
  }
}

// ✅ GradientCard Widget
class GradientCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color startColor;
  final Color endColor;
  final VoidCallback onTap;

  const GradientCard({
    super.key,
    required this.title,
    required this.icon,
    required this.startColor,
    required this.endColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: -40,
              right: -10,
              child: _buildGrayCircle(100), // Larger main circle
            ),
            Positioned(
              top: 8,
              left: 120,
              child: _buildGrayCircle(95), // Smaller overlapping circle
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 28,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Function to Create Soft Gray Circles
  Widget _buildGrayCircle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.20), // More subtle transparency
        shape: BoxShape.circle,
      ),
    );
  }
}

class EmergencyButton extends StatefulWidget {
  final bool requested;
  const EmergencyButton({super.key, required this.requested});

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

class _EmergencyButtonState extends State<EmergencyButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2, // Two cards per row
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.2,
        children: [
          GradientCard(
            title: "Emergency \nSession",
            icon: Icons.warning,
            startColor: Colors.redAccent,
            endColor: Colors.deepOrangeAccent,
            onTap: widget.requested
                ? () => Get.to(() => const CallScreen())
                : () {},
          ),
        ],
      ),
    );
  }
}

class InterpreterStreamWidget extends StatefulWidget {
  const InterpreterStreamWidget({super.key});

  @override
  State<InterpreterStreamWidget> createState() =>
      _InterpreterStreamWidgetState();
}

class _InterpreterStreamWidgetState extends State<InterpreterStreamWidget> {
  bool? _previousRequestCall;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Interpreter')
          .doc(AppConstants.userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data?.data() == null) {
          return const EmergencyButton(requested: false);
        }

        final interpreter = Interpreter.fromJson(snapshot.data!.data());
        final currentRequestCall = interpreter.requestCall ?? false;

        // Show SnackBar if the value changed and is true
        if (_previousRequestCall != null &&
            _previousRequestCall != currentRequestCall &&
            currentRequestCall == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Interpreter has requested a call')),
            );
          });
        }

        // Update the previous value
        _previousRequestCall = currentRequestCall;

        return EmergencyButton(requested: currentRequestCall);
      },
    );
  }
}

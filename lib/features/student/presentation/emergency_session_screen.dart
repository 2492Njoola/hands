import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hands_test/core/utils/constants.dart';
import 'package:hands_test/model/call.dart';
import 'package:hands_test/model/interpreter.dart';
import 'package:uuid/uuid.dart';

import 'call_screen.dart';

class EmergencySessionScreen extends StatefulWidget {
  const EmergencySessionScreen({super.key});

  @override
  State<EmergencySessionScreen> createState() => _EmergencySessionScreenState();
}

class _EmergencySessionScreenState extends State<EmergencySessionScreen> {
  bool callRequest = false;
  String callId = "";

  @override
  void initState() {
    callRequest = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return callRequest
        ? Scaffold(
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Calls')
                    .doc(callId)
                    .snapshots(),
                builder: (context, snapshot){
                  if (snapshot.hasData) {
                    final call = Call.fromJson(snapshot.data!.data());
                    if (call.acceptRequest!) {
                      // callRequest = false;

                      Future.delayed(Duration(seconds: 2)).then((val) {
                        Get.to(() => CallScreen());
                      });
                      
                    } else if (call.cancelRequest!) {
                      callRequest = false;
                      Get.back();
                    }
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text("Emergency Session"),
              backgroundColor: Colors.white, // this is a basic comment
            ),
            body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Interpreter')
                  .where('active', isEqualTo: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final interpreters = snapshot.data!.docs;
                return interpreters.isEmpty
                    ? const Center(
                        child: Text("No Interpreter available now"),
                      )
                    : ListView.builder(
                        itemCount: interpreters.length,
                        itemBuilder: (context, index) {
                          var user =
                              Interpreter.fromJson(interpreters[index].data());
                          return Card(
                            child: ListTile(
                              title: Text(user.fullName!),
                              subtitle: Text(user.id!),
                              trailing: const Icon(
                                Icons.online_prediction,
                                color: Colors.green,
                              ),
                              onTap: () async {
                                final uid = Uuid().v4();
                                final call = Call(
                                  id: uid,
                                  studentId: AppConstants.userId,
                                  interpreterId: user.id,
                                  cancelRequest: false,
                                  acceptRequest: false,
                                  request: true,
                                );
                                setState(() {
                                  callRequest = true;
                                  callId = uid;
                                });
                                await FirebaseFirestore.instance
                                    .collection("Calls")
                                    .doc(uid)
                                    .set(call.toJson());
                                // await FirebaseFirestore.instance
                                //     .collection("Interpreter")
                                //     .doc(user.id)
                                //     .update({
                                //   "request_call": true,
                                // });
                                // Get.to(() => CallScreen());
                              },
                            ),
                          );
                        },
                      );
              },
            ),
          );
  }
}

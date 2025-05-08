class Call {
  String? id;
  String? studentId;
  String? interpreterId;
  bool? cancelRequest;
  bool? acceptRequest;
  bool? request;

  Call({
    required this.id,
    required this.studentId,
    required this.interpreterId,
    required this.cancelRequest,
    required this.acceptRequest,
    required this.request,
  });

  Call.fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    studentId = map['student_id'];
    interpreterId = map['interpreter_id'];
    cancelRequest = map['cancelRequest'];
    acceptRequest = map['acceptRequest'];
    request = map['request'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'interpreter_id': interpreterId,
      'cancelRequest': cancelRequest,
      'acceptRequest': acceptRequest,
      'request': request,
    };
  }
}

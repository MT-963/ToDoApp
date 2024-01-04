import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoModel {
  final String taskTitle;
  final String taskDesc;
  final String taskCategory;
  final String taskDate;
  final String taskTime;
  String? docId;
  final bool taskState;
  ToDoModel({
    required this.taskTitle,
    required this.taskDesc,
    required this.taskCategory,
    required this.taskDate,
    required this.taskTime,
    required this.taskState,
    this.docId,
  });

  Map<String, dynamic> toMap() {
    return {
      'taskTitle': taskTitle,
      'taskDesc': taskDesc,
      'taskCategory': taskCategory,
      'taskDate': taskDate,
      'taskTime': taskTime,
      'taskState': taskState,
      'docID': docId,
    };
  }

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      taskTitle: map['taskTitle'] as String,
      taskDesc: map['taskDesc'] as String,
      taskCategory: map['taskCategory'] as String,
      taskDate: map['taskDate'] as String,
      taskTime: map['taskTime'] as String,
      taskState: map['taskState'] as bool,
      docId: map['docID'] != null ? map['docID'] as String : null,
    );
  }
  factory ToDoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) =>
      ToDoModel(
          taskTitle: doc['taskTitle'],
          taskDesc: doc['taskDesc'],
          taskCategory: doc['taskCategory'],
          taskDate: doc['taskDate'],
          taskTime: doc['taskTime'],
          taskState: doc['taskState'],
          docId: doc.reference.id);
}

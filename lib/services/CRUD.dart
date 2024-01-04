import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/ToDoModel.dart';
import 'package:flutter/material.dart';

class CRUD {
  CollectionReference crud = FirebaseFirestore.instance.collection('toDoTasks');

  Future<void> addNewTask(ToDoModel model) {
    // Call the user's CollectionReference to add a new user
    return crud
        .add(model.toMap())
        .then((doc) => model.docId = doc.id)
        .catchError((error) => print("Failed to add task: $error"));
  }

  Future getTasks() {
    return crud.get().then((QuerySnapshot querySnapshot) {
      Map<String, dynamic> data = querySnapshot as Map<String, dynamic>;
      return Text("Full Name: ${data['full_name']} ${data['last_name']}");
    });
  }

  void updateTask(String docId, bool valueUpdate) =>
      crud.doc(docId).update({'taskState': valueUpdate});
  void deleteTask(String docId) => crud.doc(docId).delete();
}

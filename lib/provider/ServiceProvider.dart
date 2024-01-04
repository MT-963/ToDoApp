import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_app/services/CRUD.dart';

import '../model/ToDoModel.dart';

final serviceProvider = StateProvider<CRUD>((ref) {
  return CRUD();
});
final fetchStreamProvider = StreamProvider<List<ToDoModel>>((ref) async* {
  final getData = FirebaseFirestore.instance
      .collection('toDoTasks')
      .snapshots()
      .map((event) => event.docs
          .map((snapshot) => ToDoModel.fromSnapshot(snapshot))
          .toList());
  yield* getData;
});

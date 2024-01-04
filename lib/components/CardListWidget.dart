import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

import '../provider/ServiceProvider.dart';
import '../screens/TaskDetails.dart';

class CardListWidget extends ConsumerWidget {
  CardListWidget(
    this.getIndex, {
    super.key,
  });

  final int getIndex;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDoData = ref.watch(fetchStreamProvider);

    return toDoData.when(
        data: (toDoData) {
          String getCategory = toDoData[getIndex].taskCategory;
          Color categoryColor = Colors.grey;
          switch (getCategory) {
            case "Oğrenme":
              categoryColor = Colors.green;
              break;
            case "Çalışma":
              categoryColor = Colors.red;
              break;
            case "Diğer":
              categoryColor = Colors.yellow;
              break;
          }
          return Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Container(
                  width: 25,
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        onTap: () => Navigator.of(context).pushNamed(
                          "taskDetail",
                        ),
                        title: Text(
                          toDoData[getIndex].taskTitle,
                          style: TextStyle(
                              decoration: toDoData[getIndex].taskState
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        subtitle: Text(
                          toDoData[getIndex].taskDesc,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13,
                              decoration: toDoData[getIndex].taskState
                                  ? TextDecoration.lineThrough
                                  : null),
                          maxLines: 1,
                        ),
                        trailing: Transform.scale(
                          scale: 1.3,
                          child: Checkbox(
                            checkColor: Colors.green,
                            value: toDoData[getIndex].taskState,
                            activeColor: Colors.white,
                            onChanged: (value) => ref
                                .read(serviceProvider)
                                .updateTask(toDoData[getIndex].docId!, value!),
                            shape: CircleBorder(),
                          ),
                        ),
                      ),
                      Gap(10),
                      Divider(thickness: 1, color: Colors.grey.shade300),
                      Row(
                        children: [
                          Text(toDoData[getIndex].taskDate),
                          Gap(20),
                          Text(toDoData[getIndex].taskTime)
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          );
        },
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}

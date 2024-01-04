import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../components/CustomAppBar.dart';

class TaskDetail extends StatefulWidget {
  const TaskDetail({super.key});

  @override
  State<TaskDetail> createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  static Duration calculateRemainingTime(String dateString) {
    // Parse the input date string into a DateTime object
    DateTime targetDate = DateTime.parse(dateString);

    // Get the current date and time
    DateTime now = DateTime.now();

    // Calculate the time difference
    Duration difference = targetDate.difference(now);

    return difference;
  }

  static String targetDateString = "2024-01-05"; // Adjust the format if needed

  // Calculate the remaining time
  Duration remainingTime = calculateRemainingTime(targetDateString);
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(context),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Görev Adı: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text(
                    '1000 adım tamamlama',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Görev Detayı: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Expanded(
                    child: Text(
                      'Konyaaltı Sahilinde sabahta yürüyüşe gitmek',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Kalan Süre: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text(
                    remainingTime.inDays.toString() +
                        ' Gün ' +
                        (remainingTime.inHours % 24).toString() +
                        ' Saat ' +
                        (remainingTime.inMinutes % 60).toString() +
                        ' Dk ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Görev Durumu: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                  Text(
                    'Tamamlanmadı',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}

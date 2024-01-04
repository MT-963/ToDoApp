import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/components/CustomButton.dart';
import 'package:gap/gap.dart';
import 'package:to_do_app/constants/AppStyle.dart';
import 'package:to_do_app/model/ToDoModel.dart';
import 'package:to_do_app/provider/DateTimeProvider.dart';
import 'package:to_do_app/provider/RadioProvider.dart';
import '../provider/ServiceProvider.dart';
import 'DateTimeWidget.dart';

import 'CustomRadio.dart';
import 'NewTaskTextForm.dart';

class AddNewTask extends StatefulWidget {
  AddNewTask({
    super.key,
  });

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  TextEditingController controllTaskName = TextEditingController();

  TextEditingController controllTaskDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.70,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Text(
                  'Yeni Görev',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 23, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(thickness: 1),
              Text(
                'Yeni Görev Başlığı',
                textAlign: TextAlign.center,
                style: AppStyle.headingStyle,
              ),
              const Gap(5),
              NewTaskTextForm(
                controllTaskName: controllTaskName,
                labelText: 'Görev Adı..',
              ),
              const Gap(10),
              Text(
                'Görev Tanımı',
                textAlign: TextAlign.center,
                style: AppStyle.headingStyle,
              ),
              const Gap(2),
              NewTaskTextForm(
                controllTaskName: controllTaskDescription,
                labelText: 'Tam olarak ne yapacaksınız..',
                maxLines: 4,
              ),
              const Gap(10),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                    Row(
                  children: [
                    Expanded(
                      child: CustomRadio(
                        color: Colors.green,
                        text: 'Öğrenme',
                        value: 1,
                        onChange: () => ref
                            .read(radioProvider.notifier)
                            .update((state) => 1),
                      ),
                    ),
                    Expanded(
                      child: CustomRadio(
                        color: Colors.red,
                        text: 'Çalışma',
                        value: 2,
                        onChange: () => ref
                            .read(radioProvider.notifier)
                            .update((state) => 2),
                      ),
                    ),
                    Expanded(
                      child: CustomRadio(
                        color: Colors.yellow,
                        text: 'Diğer',
                        value: 3,
                        onChange: () => ref
                            .read(radioProvider.notifier)
                            .update((state) => 3),
                      ),
                    ),
                  ],
                ),
              ),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) {
                  final dateProv = ref.watch(dateProvider);
                  return Row(
                    children: [
                      DateTimeWidget(
                          icon: Icons.calendar_month,
                          text: dateProv,
                          title: 'Tarih',
                          onTap: () async {
                            final datePicked = await showDatePicker(
                                context: context,
                                firstDate: DateTime(2023),
                                lastDate: DateTime(2026),
                                initialDate: DateTime.now());
                            if (datePicked != null) {
                              var format = DateFormat('yyyy-MM-dd');
                              ref
                                  .read(dateProvider.notifier)
                                  .update((state) => format.format(datePicked));
                              print(format.format(datePicked));
                            }
                          }),
                      const Gap(25),
                      DateTimeWidget(
                        icon: Icons.calendar_month,
                        text: ref.watch(timeProvider),
                        title: 'Saat',
                        onTap: () async {
                          final timePicker = await showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                          if (timePicker != null) {
                            ref
                                .read(timeProvider.notifier)
                                .update((state) => timePicker.format(context));
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
              Gap(12),
              Consumer(
                builder: (BuildContext context, WidgetRef ref, Widget? child) =>
                    Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onPressed: () async {
                          String radioText = '';
                          switch (ref.watch(radioProvider)) {
                            case 1:
                              radioText = 'Oğrenme';
                              break;
                            case 2:
                              radioText = 'Çalışma';
                              break;
                            case 3:
                              radioText = 'Diğer';
                              break;
                          }
                          showDialog(
                            context: context,
                            builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.green),
                            ),
                          );
                          await ref
                              .watch(serviceProvider)
                              .addNewTask(
                                ToDoModel(
                                  taskTitle: controllTaskName.text,
                                  taskDesc: controllTaskDescription.text,
                                  taskCategory: radioText,
                                  taskDate: ref.watch(dateProvider),
                                  taskTime: ref.watch(timeProvider),
                                  taskState: false,
                                ),
                              )
                              .then(
                            (value) async {
                              Navigator.of(context).pop();
                              await AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.scale,
                                desc: 'Görev başarı ile eklendi',
                                title: 'Bravo',
                                autoHide: const Duration(seconds: 3),
                              ).show();
                            },
                          );
                          Navigator.of(context).pop();
                        },
                        buttonText: 'Ekle',
                      ),
                    ),
                    Gap(25),
                    Expanded(
                      child: CustomButton(
                        onPressed: () => Navigator.pop(context),
                        buttonText: 'Iptal et',
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

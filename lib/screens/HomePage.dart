import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/provider/FirebaseProvider.dart';
import 'package:to_do_app/services/CRUD.dart';
import '../components/AddNewTask.dart';
import '../components/CardListWidget.dart';
import '../components/CustomAppBar.dart';
import '../components/CustomButton.dart';
import '../provider/ServiceProvider.dart';
import 'MotivationPage.dart';

class HomePage extends ConsumerWidget {
  HomePage({super.key});

  GlobalKey<FormState> formstate = GlobalKey();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final toDoData = ref.watch(fetchStreamProvider);
    return toDoData.when(
        data: (toDoData) => Scaffold(
              drawer: Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Motivation App',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text('Home'),
                      onTap: () {
                        // Navigate to the home page or handle as needed
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      title: Text('Motivation Page'),
                      onTap: () {
                        // Navigate to the motivation page or handle as needed
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MotivationPage()));
                      },
                    ),
                    // Add more ListTile items for other pages or features
                  ],
                ),
              ),
              backgroundColor: Colors.grey[200],
              appBar: CustomAppBar(context),
              body: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Günün Görevi',
                              style: GoogleFonts.sansita(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd').format(DateTime.now()),
                              style: GoogleFonts.roboto(
                                fontSize: 10,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 120,
                          child: CustomButton(
                            buttonText: '+ Yeni Görev',
                            onPressed: () => showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => AddNewTask(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Gap(10),
                    ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: toDoData.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Slidable(
                        child: CardListWidget(
                          index,
                        ),
                        startActionPane: ActionPane(
                          extentRatio: 0.3,
                          motion: const StretchMotion(),
                          children: [
                            SlidableAction(
                              label: 'Sil',
                              backgroundColor: Colors.grey.shade200,
                              icon: Icons.delete,
                              onPressed: (BuildContext context) => ref
                                  .read(serviceProvider)
                                  .deleteTask(toDoData[index].docId!),
                            )
                          ],
                        ),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          Gap(15),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}

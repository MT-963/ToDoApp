import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../provider/FirebaseProvider.dart';

AppBar CustomAppBar(BuildContext context) {
  return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade300,
          backgroundImage: AssetImage("assets/images/avatar.png"),
          radius: 25,
        ),
        title: Text(
          'Merhaba',
          style: GoogleFonts.roboto(
            fontSize: 10,
            color: Colors.grey[700],
          ),
        ),
        subtitle: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) => Text(
            ref.read(firebaseAuth).currentUser!.displayName.toString(),
            style: GoogleFonts.roboto(
                fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.calendar_month),
          color: Colors.black,
        ),
        IconButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            FirebaseAuth.instance.currentUser == null;
            Navigator.of(context).pushReplacementNamed("authScreen");
          },
          icon: Icon(Icons.exit_to_app),
          color: Colors.black,
        ),
      ]);
}

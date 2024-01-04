// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:to_do_app/components/CustomAppBar.dart';

class SansorPage extends StatefulWidget {
  const SansorPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<SansorPage> createState() => _SansorPageState();
}

class _SansorPageState extends State<SansorPage> {
  int _stepCount = 0;
  String _selectedMethod = 'Method 1'; // Default counting method

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  void _logStepCountEvent() async {
    await _analytics.logEvent(
      name: 'step_count',
      parameters: {'count': _stepCount, 'method': _selectedMethod},
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Step Count:',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                '$_stepCount',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedMethod,
                items: ['Method 1', 'Method 2', 'Method 3']
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedMethod = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    // Increment the step count based on the selected method
                    // Replace this logic with your actual step counting method
                    _stepCount += 100;
                    // Log analytics event when step count changes
                    _logStepCountEvent();
                  });
                },
                child: Text('Increment Step Count'),
              ),
            ],
          ),
        ),
      );
}

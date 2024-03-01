// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_flutter_app/Util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Handle taps outside the AlertDialog
      onTap: () {
        Navigator.pop(context); // Close the dialog
      },
      child: AlertDialog(
        backgroundColor: Colors.yellow[300],
        content: Container(
          height: 120,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ignore: prefer_const_constructors
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Add a new Task",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                          color: Colors.black), // Color when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black), // Color when focused
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MyButton(
                      text: "Add",
                      onPressed: onSave,
                      color: Colors.yellow,
                    ),
                    MyButton(
                      text: "Cancel",
                      onPressed: onCancel,
                      color: Colors.grey[300],
                    ),
                  ],
                )
              ]),
        ),
      ),
    );
  }
}

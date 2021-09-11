import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({Key? key, this.progressVal}) : super(key: key);
  final progressVal;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Uploading...",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          CircularProgressIndicator(
            value: progressVal,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.brown.shade400),
          )
        ],
      ),
    );
  }
}

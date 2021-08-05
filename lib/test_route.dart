import 'package:flutter/material.dart';

class TestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(title: Text('Test Route')),
          body: GestureDetector(
            child: Text('Hi'),
            onTap: () {
              // Navigator.pop(context);
            },
          )),
    );
  }
}

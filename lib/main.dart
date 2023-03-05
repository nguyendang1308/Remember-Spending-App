// ignore_for_file: sort_child_properties_last, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal/widgets/new_transaction.dart';
import 'package:personal/widgets/transaction_list.dart';
import 'package:personal/widgets/user_transaction.dart';

void main() => runApp(Personal());

class Personal extends StatefulWidget {
  const Personal({super.key});

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  // String? titleInput;
  // String? amountIntput;
  final titleController = TextEditingController();
  final amountControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal App"),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            // ignore: prefer_const_constructors
            child: Card(
              color: Colors.blue,
              child: Text("Chart"),
              elevation: 5,
            ),
          ),
          UserTransaction(),
        ],
      ),
    );
  }
}

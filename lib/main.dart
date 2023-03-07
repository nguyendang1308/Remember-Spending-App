// ignore_for_file: sort_child_properties_last, prefer_const_constructors, duplicate_ignore

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:personal/widgets/chart.dart';
import 'package:personal/widgets/new_transaction.dart';
import 'package:personal/widgets/transaction_list.dart';
import 'package:personal/models/transaction.dart';
import 'package:screenshot/screenshot.dart';

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
      title: 'Personal Expenses',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.purple,
        fontFamily: 'OpenSans',
        errorColor: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Screenshot
  final controller = ScreenshotController();

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 'ID01',
    //   title: 'Shoes',
    //   amount: 10,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'ID02',
    //   title: 'Drink',
    //   amount: 10,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  int count = 2;
  void _addTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    count += 1;
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  // String? titleInput;
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: controller,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColor,
          ),
          title: Container(
            alignment: Alignment.center,
            child: Text(
              "Quản Lý Hũ Chi Tiêu",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              onPressed: () async {
                final img = await controller.capture();
                if (img == null) return;
                await saveImage(img);
              },
              icon: Icon(
                Icons.screen_share,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => _startAddNewTransaction(context),
            ),
          ],
        ),
        body: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentTransactions),
            TransactionList(_userTransaction, _deleteTransaction),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = 'screenshot_$time';
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result['filePath'];
  }
}

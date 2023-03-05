import 'package:flutter/material.dart';
import 'package:personal/widgets/new_transaction.dart';
import 'package:personal/widgets/transaction_list.dart';
import 'package:personal/models/transaction.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({super.key});

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 'ID01',
      title: 'Shoes',
      amount: 10,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'ID02',
      title: 'Drink',
      amount: 10,
      date: DateTime.now(),
    ),
  ];
  int count = 2;
  void _addTransaction(String txTitle, double txAmount) {
    count += 1;
    final newTx = Transaction(
      id: 'ID $count ',
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addTransaction),
        TransactionList(_userTransaction),
      ],
    );
  }
}

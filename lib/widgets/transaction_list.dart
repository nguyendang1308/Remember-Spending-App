import 'package:flutter/material.dart';
import 'package:personal/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "List Is Empty",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('\$${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(DateFormat('hh:mm MM/dd/yyyy')
                          .format(transactions[index].date)),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                      ),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}

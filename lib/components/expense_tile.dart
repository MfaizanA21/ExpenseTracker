import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final void Function(BuildContext)? deleteTapped;
  final void Function(BuildContext)? editTapped;

  ExpenseTile({
    Key? key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    required this.editTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: Colors.grey[700],
      child: Slidable(
        endActionPane: ActionPane(
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => _showDeleteConfirmation(context),
              icon: Icons.delete_outline_outlined,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              label: 'Delete',
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) => editTapped?.call(context),
              icon: Icons.edit,
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              label: 'Edit',
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          leading: Icon(Icons.monetization_on_rounded, color: Colors.green, size: 28),
          title: Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          subtitle: Text(
            '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}',
            style: TextStyle(color: Colors.grey[400], fontSize: 14),
          ),
          trailing: Text(
            'Rs $amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green[300],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[800],
        title: Text(
          'Confirm Deletion',
          style: TextStyle(color: Colors.white), // White text
        ),
        content: Text(
          'Are you sure you want to delete this expense?',
          style: TextStyle(color: Colors.white70), // Slightly greyed-out white text
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteTapped?.call(context);
            },
            child: Icon(Icons.check, color: Colors.green),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.close, color: Colors.red),
          ),
        ],
      ),
    );
  }

}

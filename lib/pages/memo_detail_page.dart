import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sns_app/modules/memo.dart';

class MemoDetailPage extends StatelessWidget {
  const MemoDetailPage(this.memo, {super.key});

  final Memo memo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('メモ詳細')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  memo.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(DateFormat.MMMd('ja_JP').format(memo.createAt.toDate()),style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),),
              ],
            ),
            const SizedBox(height: 16),
            Text('詳細', style: TextStyle(color: Colors.grey)),
            Text(memo.content),
          ],
        ),
      ),
    );
  }
}

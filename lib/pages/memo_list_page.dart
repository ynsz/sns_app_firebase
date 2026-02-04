import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sns_app/modules/memo.dart';
import 'package:sns_app/pages/memo_create_page.dart';
import 'package:sns_app/pages/memo_detail_page.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key, required this.title});

  final String title;

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  final memoCol = FirebaseFirestore.instance.collection('memos');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('メモ一覧'),
      ),
      body: StreamBuilder(
        stream: memoCol.orderBy('createAt', descending: true).snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text(asyncSnapshot.error.toString()));
          }

          final docs = asyncSnapshot.data?.docs;
          if (docs == null || docs.isEmpty) {
            return const Center(child: Text('メモの情報がありません'));
          }
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data();
              final memo = Memo(
                title: data['title'],
                content: data['content'],
                createAt: data['createAt'],
                updateAt: data['updateAt'],
              );
              return ListTile(
                title: Text(memo.title),
                subtitle: Text(memo.content),
                trailing: Text(
                  DateFormat.yMMMMEEEEd('ja_JP').format(memo.createAt.toDate()),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemoDetailPage(memo),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MemoCreatePage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

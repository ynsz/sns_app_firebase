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
  var memoList = <Memo>[];

  Future<void> fetchMemos() async {
    final firestore = FirebaseFirestore.instance;
    final memoCol = firestore.collection('memos');
    final snapshot = await memoCol.get();
    final docs = snapshot.docs;
    memoList = docs.map((doc) {
      final data = doc.data();
      return Memo(
        title: data['title'],
        content: data['content'],
        createAt: data['createAt'],
        updateAt: data['updateAt'],
      );
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchMemos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('メモ一覧'),
      ),
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(memoList[index].title),
            subtitle: Text(memoList[index].content),
            trailing: Text(
              DateFormat.yMMMMEEEEd(
                'ja_JP',
              ).format(memoList[index].createAt.toDate()),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoDetailPage(memoList[index]),
                ),
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

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sns_app/modules/memo.dart';

class MemoListPage extends StatefulWidget {
  const MemoListPage({super.key, required this.title});

  final String title;

  @override
  State<MemoListPage> createState() => _MemoListPageState();
}

class _MemoListPageState extends State<MemoListPage> {
  final memoList = [
    Memo(
      title: 'test1',
      content: 'test1の詳細',
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    ),
    Memo(
      title: 'test2',
      content: 'test2の詳細',
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    ),
  ];

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
              DateFormat.yMMMMEEEEd('ja_JP').format(memoList[index].createAt),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

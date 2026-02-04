import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MemoCreatePage extends StatefulWidget {
  const MemoCreatePage({super.key});

  @override
  State<MemoCreatePage> createState() => _MemoCreatePageState();
}

class _MemoCreatePageState extends State<MemoCreatePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> createMemo() async {
    final memoCol = FirebaseFirestore.instance.collection('memos');
    await memoCol.add({
      'title': titleController.text,
      'content': contentController.text,
      'createAt': FieldValue.serverTimestamp(),
      'updateAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('メモ作成')),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('タイトル'),
                const SizedBox(height: 4),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                const SizedBox(height: 16),
                const Text('詳細'),
                const SizedBox(height: 4),
                TextField(
                  controller: contentController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await createMemo();
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('メモを追加する'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sns_app/modules/memo.dart';

class MemoUpsertPage extends StatefulWidget {
  const MemoUpsertPage({super.key, this.memo});

  final Memo? memo;

  @override
  State<MemoUpsertPage> createState() => _MemoUpsertPageState();
}

class _MemoUpsertPageState extends State<MemoUpsertPage> {
  late final isCreate = widget.memo == null;
  final memoCol = FirebaseFirestore.instance.collection('memos');
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Future<void> createMemo() async {
    await memoCol.add({
      'title': titleController.text,
      'content': contentController.text,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<Memo> updateMemo(String memoId) async {
    final targetDoc = memoCol.doc(memoId);
    await targetDoc.update({
      'title': titleController.text,
      'content': contentController.text,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return Memo(
      id: memoId,
      title: titleController.text,
      content: contentController.text,
      createdAt: widget.memo!.createdAt,
      updatedAt: Timestamp.now(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (!isCreate) {
      titleController.text = widget.memo!.title;
      contentController.text = widget.memo!.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isCreate ? 'メモ作成' : 'メモ編集')),
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
                      Memo? generatedMemo;
                      if (isCreate) {
                        await createMemo();
                      } else {
                        generatedMemo = await updateMemo(widget.memo!.id);
                      }
                      if (context.mounted) {
                        Navigator.pop(context, generatedMemo);
                      }
                    },
                    child: Text(isCreate ? 'メモを追加する' : 'メモを更新する'),
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

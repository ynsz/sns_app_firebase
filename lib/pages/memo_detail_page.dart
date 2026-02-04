import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sns_app/modules/memo.dart';
import 'package:sns_app/pages/memo_upsert_page.dart';

class MemoDetailPage extends StatefulWidget {
  const MemoDetailPage(this.memo, {super.key});

  final Memo memo;

  @override
  State<MemoDetailPage> createState() => _MemoDetailPageState();
}

class _MemoDetailPageState extends State<MemoDetailPage> {
  late Memo cachedMemo = widget.memo;

  Future<void> deleteMemo() async {
    final doc = FirebaseFirestore.instance
        .collection('memos')
        .doc(cachedMemo.id);
    await doc.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ詳細'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(),
                builder: (context) {
                  return SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('編集'),
                          leading: Icon(Icons.edit),
                          onTap: () async {
                            Navigator.pop(context);
                            final result = await Navigator.push<Memo>(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MemoUpsertPage(memo: cachedMemo),
                              ),
                            );
                            if (result != null) {
                              cachedMemo = result;
                              setState(() {});
                            }
                          },
                        ),
                        ListTile(
                          title: const Text('削除'),
                          leading: Icon(Icons.delete),
                          onTap: () async {
                            await deleteMemo();
                            if (context.mounted) {
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.more_horiz),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cachedMemo.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.MMMd(
                    'ja_JP',
                  ).format(cachedMemo.createdAt.toDate()),
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text('詳細', style: TextStyle(color: Colors.grey)),
            Text(cachedMemo.content),
          ],
        ),
      ),
    );
  }
}

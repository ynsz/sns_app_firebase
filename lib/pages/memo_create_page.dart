import 'package:flutter/material.dart';

class MemoCreatePage extends StatefulWidget {
  const MemoCreatePage({super.key});

  @override
  State<MemoCreatePage> createState() => _MemoCreatePageState();
}

class _MemoCreatePageState extends State<MemoCreatePage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

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
                    onPressed: () {
                      print('タイトル: ${titleController.text}');
                      print('詳細: ${contentController.text}');
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

import 'package:cloud_firestore/cloud_firestore.dart';

class Memo {
  final String title;
  final String content;
  final Timestamp createAt;
  final Timestamp updateAt;

  Memo ({
    required this.title,
    this.content = '',
    required this.createAt,
    required this.updateAt,
  });
}
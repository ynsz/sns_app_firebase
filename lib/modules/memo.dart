class Memo {
  final String title;
  final String content;
  final DateTime createAt;
  final DateTime updateAt;

  Memo ({
    required this.title,
    this.content = '',
    required this.createAt,
    required this.updateAt,
  });
}
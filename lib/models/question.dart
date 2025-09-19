class Question {
  final String text;
  final List<String> options;
  final int correctIndex;
  final String imageLink;
  int selectAnswer; // -1 = not answered

  Question({
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.imageLink,
    this.selectAnswer = -1,
  });

  // Deep copy helper
  Question copy() => Question(
    text: text,
    options: List<String>.from(options),
    correctIndex: correctIndex,
    imageLink: imageLink,
    selectAnswer: selectAnswer,
  );

  Map<String, dynamic> toJson() => {
    'text': text,
    'options': options,
    'correctIndex': correctIndex,
    'imageLink': imageLink,
    'selectAnswer': selectAnswer,
  };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    text: json['text'] as String,
    options: List<String>.from(json['options'] as List),
    correctIndex: json['correctIndex'] as int,
    imageLink: (json['imageLink'] as String?) ?? '',
    selectAnswer: (json['selectAnswer'] as int?) ?? -1,
  );
}

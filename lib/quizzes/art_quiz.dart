import 'package:space_scutum_test_permiakov/models/question.dart';

final List<Question> artQuestions = [
  Question(
    text: "Who painted the Mona Lisa?",
    options: ["Vincent van Gogh", "Leonardo da Vinci", "Pablo Picasso"],
    correctIndex: 1,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/960px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg',
  ),
  Question(
    text: "Which art movement is Salvador Dalí associated with?",
    options: ["Impressionism", "Surrealism", "Cubism"],
    correctIndex: 1,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/2/24/Salvador_Dal%C3%AD_1939.jpg',
  ),
  Question(
    text: "The Sistine Chapel ceiling was painted by:",
    options: ["Michelangelo", "Raphael", "Caravaggio"],
    correctIndex: 0,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/Sistine_Chapel_ceiling_02_%28brightened%29.jpg/960px-Sistine_Chapel_ceiling_02_%28brightened%29.jpg',
  ),
  Question(
    text: "Which artist cut off part of his own ear?",
    options: ["Vincent van Gogh", "Claude Monet", "Paul Cézanne"],
    correctIndex: 0,
    imageLink: '',
  ),
  Question(
    text: "\"The Persistence of Memory\" shows melting:",
    options: ["Clocks", "Candles", "Fruits"],
    correctIndex: 0,
    imageLink: '',
  ),
];

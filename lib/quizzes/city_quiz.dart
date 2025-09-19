import 'package:space_scutum_test_permiakov/models/question.dart';

final List<Question> cityQuestions = [
  Question(
    text: "Which city is called \"The Big Apple\"?",
    options: ["New York", "Los Angeles", "Chicago"],
    correctIndex: 0,
    imageLink: '',
  ),
  Question(
    text: "The Eiffel Tower is in:",
    options: ["Rome", "Paris", "Berlin"],
    correctIndex: 1,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg/330px-Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg',
  ),
  Question(
    text: "The Colosseum is located in:",
    options: ["Rome", "Athens", "Madrid"],
    correctIndex: 0,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Colosseo_2020.jpg/1200px-Colosseo_2020.jpg',
  ),
  Question(
    text: "The Burj Khalifa is in:",
    options: ["Doha", "Dubai", "Riyadh"],
    correctIndex: 1,
    imageLink:
        'https://upload.wikimedia.org/wikipedia/en/thumb/9/93/Burj_Khalifa.jpg/250px-Burj_Khalifa.jpg',
  ),
  Question(
    text: "Which city is the capital of Canada?",
    options: ["Toronto", "Ottawa", "Vancouver"],
    correctIndex: 1,
    imageLink:
        'https://www.internationalcitizens.com/wp-content/uploads/2022/09/iStock-1178852373.jpg',
  ),
];

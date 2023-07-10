// ignore_for_file: file_names, constant_identifier_names

class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.options,
  });
}

const List sample_data = [
  {
    "id": 1,
    "question": "How are String represented in memory in C?",
    "options": [
      'An array of characters.',
      'The object of some class.',
      'Same as primitive data.',
      'LinkedList of characters.'
    ],
    "answer_index": 0,
  },
  {
    "id": 2,
    "question": "Number of primitive data types in Java are?",
    "options": ['6', '7', '8', '9'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question":
        "Identify the return type of a method that does not return any value.",
    "options": ['int', 'void', 'double', 'None'],
    "answer_index": 1,
  },
  {
    "id": 4,
    "question":
        "Which of the following sorting algorithms provides the best time complexity in the worst case scenario?",
    "options": ['Quick sort', 'Bubble sort', 'Merge sort', 'Selection sort'],
    "answer_index": 2,
  },
  {
    "id": 5,
    "question":
        "How is the second element in an array accessed based on pointer notation?",
    "options": ['*a+2', '*(*a+2)', '*(a+2)', '&(a+2)'],
    "answer_index": 2,
  },
  {
    "id": 6,
    "question": "What does MIME stand for?",
    "options": [
      'Multipurpose internet mail',
      'Multi internet mail end',
      'Multi internet mail email',
      'Multipurpose internet mail'
    ],
    "answer_index": 3,
  },
  {
    "id": 7,
    "question": "Which of the following is valid?",
    "options": ['<_person>', '<123 person>', 'Both a and b', 'None of these'],
    "answer_index": 0,
  },
  {
    "id": 8,
    "question": "Basic XML can be described as:",
    "options": [
      'A hierarchial structure.',
      'All the HTML tags.',
      'Object oriented.',
      'Processing instructions(pls)for text data'
    ],
    "answer_index": 0,
  },
  {
    "id": 9,
    "question": "Which type of Programming does Python support?",
    "options": [
      ' object-oriented programming',
      'structured programming',
      'functional programming',
      'all of the mentioned'
    ],
    "answer_index": 3,
  },
  {
    "id": 10,
    "question":
        "Which of the following functions is a built-in function in python?",
    "options": [
      'factorial()',
      'print()',
      'seed()',
      'sqrt()',
    ],
    "answer_index": 1,
  },
];

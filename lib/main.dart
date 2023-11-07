//import 'dart:html';

import 'package:codingexam/models/questions_and_answer.dart';
import 'package:codingexam/views/results.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coding Exam',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Coding Exam'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  var questions = [
    QuestionsAndAnswers(
        question:
            "You went to a party last night and when you arrived to school the next day, everybody is talking about something you didn’t do. What will you do?",
        answerA: "Avoid everything and go with your friends",
        answerB: "Go and talk with the person that started the rumors",
        answerC: "Go and talk with the teacher"),
    QuestionsAndAnswers(
        question: "What quality do you excel the most?",
        answerA: "Empathy",
        answerB: "Curiosity",
        answerC: "Perseverance"),
    QuestionsAndAnswers(
        question:
            "You are walking down the street when you see an old lady trying to cross, what will you do?",
        answerA: "Go and help her",
        answerB: "Go for a policeman and ask him to help",
        answerC: "Keep walking ahead"),
    QuestionsAndAnswers(
        question:
            "You had a very difficult day at school, you will maintain a ____ attitude",
        answerA: "Depends on the situation",
        answerB: "Positive",
        answerC: "Negative"),
    QuestionsAndAnswers(
      question:
          "You are at a party and a friend of yours comes over and offers you a drink, what do you do?",
      answerA: "Say no thanks",
      answerB: "Drink it until it is finished",
      answerC: "Ignore him and get angry at him",
    ),
    QuestionsAndAnswers(
        question: "You just started in a new school, you will...",
        answerA: "Go and talk with the person next to you",
        answerB: "Wait until someone comes over you",
        answerC: "Not talk to anyone"),
    QuestionsAndAnswers(
        question: "In a typical Friday, you would like to..",
        answerA: "Go out with your close friends to eat",
        answerB: "Go to a social club and meet more people",
        answerC: "Invite one of your friends to your house"),
    QuestionsAndAnswers(
        question: "Your relationship with your parents is..",
        answerA: "I like both equally",
        answerB: "I like both equally",
        answerC: "I like my Mom the most")
  ];
  var randomNumber = Random();

  @override
  Widget build(BuildContext context) {
    var questionsNumberList = [];
    int rndNumber = randomNumber.nextInt(8);
    var answerList = ["", "", "", "", "", "", "", ""];
    List<TextEditingController> _controller = [];

    for (int i = 0; i < questions.length; i++) {
      while (questionsNumberList.contains(rndNumber)) {
        rndNumber = randomNumber.nextInt(8);
      }
      questionsNumberList.add(rndNumber);
    }

    for (int i = 1; i < 75; i++) _controller.add(TextEditingController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              for(int index = 0; index < questions.length; index++)
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${index + 1}. " + questions[questionsNumberList[index]].question),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("a. " + questions[questionsNumberList[index]].answerA),
                    Text("b. " + questions[questionsNumberList[index]].answerB),
                    Text("c. " + questions[questionsNumberList[index]].answerC),
                    TextFormField(
                      controller: _controller[index],
                      validator: (value) {
                        answerList[index] = value.toString();
                        if (!(value == "a" || value == "b" || value == "c")) {
                          return 'Invalid Input';
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    index == questions.length - 1
                        ? ElevatedButton(
                            onPressed: () {
                              if(validateForm()){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ResultsView(answers: answerList, questionsNumberList: questionsNumberList),
                                  ),
                                );
                              }
                            },
                            child: Text("Submit"),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
          });
        },
        tooltip: 'New Test',
        child: const Icon(Icons.add),
      ),
    );
  }

  bool validateForm() {
    final FormState? form = _formKey.currentState;
    bool isValid = false;
    if (form!.validate()) {
      isValid = true;
    } else {
      isValid = false;
    }
    return isValid;
  }
}

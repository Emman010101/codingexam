import 'package:flutter/material.dart';

class ResultsView extends StatefulWidget {
  List<String> answers;
  var questionsNumberList;
  ResultsView({super.key, required this. answers, required this.questionsNumberList});

  @override
  State<ResultsView> createState() => _ResultsViewState();
}

class _ResultsViewState extends State<ResultsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Coding Exam"),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(children: [
                  Text('Question #'),
                  Text('Answer'),
                ],
                ),
                for(int index = 0; index < widget.answers.length; index++)
                  TableRow(children: [
                    Text((widget.questionsNumberList[index]+1).toString()),
                    Text(widget.answers[index]),
                  ]),
              ],
            ),
            const SizedBox(height: 10,),
            Text("count(a): ${reOccurrenceCounter("a")}"),
            Text("count(b): ${reOccurrenceCounter("b")}"),
            Text("count(c): ${reOccurrenceCounter("c")}"),
            Text("Total Answers: ${reOccurrenceCounter("a")+reOccurrenceCounter("b")+reOccurrenceCounter("c")}"),
            const SizedBox(height: 10,),
            Text("Result: ${highestNumberComparer()}"),
          ],
        )
      ),
    );
  }

  int reOccurrenceCounter(String letterToCount){
    int count = 0;
    for(int i = 0; i < widget.answers.length; i++){
      if(widget.answers[i] == letterToCount){
        count++;
      }
    }
    return count;
  }

  String highestNumberComparer(){
    int aCount = reOccurrenceCounter("a");
    int bCount = reOccurrenceCounter("b");
    int cCount = reOccurrenceCounter("c");
    String result = "";
    if(aCount > bCount && aCount > cCount){
      result = "Empathy You are emphatic. You see yourself in someone else’s situation before doing decisions. You tend to listen to other’s voices.";
    }else if(cCount > aCount && cCount > bCount){
      result = "Self-Management You manage yourself well; You take responsibility for your own behavior and well-being.";
    }else{
      result = "Self-Awareness You are conscious of your own character, feelings, motives, and desires. The process can be painful but it leads to greater self-awareness.";
    }
    return result;
  }
}

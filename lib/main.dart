import 'package:chatbot/chat.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(brightness: Brightness.light),
    debugShowCheckedModeBanner: false,
    home: chatapp(),
  ));
}

class chatapp extends StatefulWidget {
  const chatapp({super.key});

  @override
  State<chatapp> createState() => _chatappState();
}

class _chatappState extends State<chatapp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFD97007),
          title: Text(
            "TARA- A chatbot",
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _showDialog(context);
                },
                child: Icon(
                  Icons.help,
                  size: 20.0,
                ),
              ),
            )
          ],
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/tara.jpg"), fit: BoxFit.cover))),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.chat),
          backgroundColor: Color(0xFFD97007),
          onPressed: (() {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => chatpage(),
                ));
          }),
          label: Text('Chat'),
          tooltip: "Connect to TARA",
        ));
  }
}

// user defined function
void _showDialog(BuildContext context) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(
          "Hello! My name is TARA. ",
          textAlign: TextAlign.center,
        ),
        content: new Text(
          "I'm created using Flutter and DialogFlow. Feel free to ask me anything in a conversational way. I'm constantly learning and adapting to better serve you, and I'm always here to help you 24/7. I'm always here to lend an ear. Let's get started!",
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

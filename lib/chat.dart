import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'Messages.dart';

class chatpage extends StatefulWidget {
  const chatpage({super.key});

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  late DialogFlowtter dialogFlowtter;
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    //implement initState
    DialogFlowtter.fromFile().then((instance) => dialogFlowtter = instance);
    super.initState();
  }

  @override
  void dispose() {
    dialogFlowtter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 224, 228, 226),
        appBar: AppBar(
          backgroundColor: Color(0xFFD97007),
          title: const Text("TARA"),
        ),
        body: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              color: Color(0xFF9A8066),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.white),
                  )),
                  IconButton(
                    onPressed: () {
                      sendMessage(_controller.text); //send message
                      _controller.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

//function
  void sendMessage(String text) async {
    if (text.isEmpty) {
      // print("Message is empty!");
      final snackBar = SnackBar(
        content: const Text(
          'Message is empty!',
          style: TextStyle(color: Color(0xFF3F3D3D)),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 80),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        action: SnackBarAction(
          label: 'Dismiss',
          onPressed: () {},
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      setState(() {
        addMessage(Message(text: DialogText(text: [text])),
            true); //sending Dialogflowtter the message from user
      });
      DetectIntentResponse response = await dialogFlowtter.detectIntent(
          queryInput: QueryInput(text: TextInput(text: text)));
      if (response.message == null)
        return; //if null don't do anything return empty
      setState(() {
        addMessage(response.message!); //Dialogflowtter message
      });
    }
  }

//both of them using this to add message.
  void addMessage(Message message, [bool isUserMessage = false]) {
    //default value
    //here we are handling the messages from the dialogflowtter is returning
    messages.add({
      'message': message,
      'isUserMessage': isUserMessage,
    });
  }
}

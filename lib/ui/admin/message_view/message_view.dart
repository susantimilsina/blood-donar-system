import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInuser;
final focusNode = FocusNode();

// ignore: use_key_in_widget_constructors
class MessageViewScreen extends StatefulWidget {
  const MessageViewScreen(
      {super.key,
      required this.userId,
      required this.userName,
      this.fromHomePage = false});
  final String userId;
  final String userName;
  final bool fromHomePage;
  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<MessageViewScreen> {
  final controller = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool isKeyboardVisible = false;
  // ignore: prefer_typing_uninitialized_variables
  var messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyboardVisibilityController.onChange.listen((bool isKeyboardVisible) {
      setState(() {
        this.isKeyboardVisible = isKeyboardVisible;
      });
    });
  }

  Future<bool> onBackPress() {
    Navigator.pop(context);

    return Future.value(false);
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInuser = user;
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userName),
      ),
      body: SafeArea(
        child: WillPopScope(
          onWillPop: onBackPress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(id: widget.userId),
              Container(
                width: double.infinity,
                height: 50.0,
                margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.blue, width: 0.5)),
                    color: Colors.white),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        textInputAction: TextInputAction.send,
                        keyboardType: TextInputType.multiline,
                        focusNode: focusNode,
                        // onSubmitted: (value) {
                        //   controller.clear();
                        //   if (widget.fromHomePage) {
                        //     _firestore
                        //         .collection('messages')
                        //         .doc(widget.userId)
                        //         .set({
                        //       "username": widget.userName,
                        //     });
                        //   }
                        //   _firestore
                        //       .collection('messages')
                        //       .doc(widget.userId)
                        //       .collection(
                        //           "${widget.userId}-${loggedInuser!.uid}")
                        //       .add({
                        //     'sender': loggedInuser!.uid,
                        //     'text': messageText,
                        //     'timestamp': Timestamp.now(),
                        //   });
                        // },
                        maxLines: null,
                        controller: controller,
                        onChanged: (value) {
                          messageText = value;
                        },
                        style: const TextStyle(
                            color: Colors.blueGrey, fontSize: 15.0),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'Type Something...',
                          hintStyle: TextStyle(color: Colors.blueGrey),
                        ),
                      ),
                    ),
                    Material(
                      // ignore: sort_child_properties_last
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            controller.clear();
                            if (widget.fromHomePage) {
                              _firestore
                                  .collection('messages')
                                  .doc(widget.userId)
                                  .set({
                                "username": widget.userName,
                              });
                            }
                            _firestore
                                .collection('messages')
                                .doc(widget.userId)
                                .collection(
                                    "${widget.userId}-${loggedInuser!.uid}")
                                .add({
                              'sender': loggedInuser!.uid,
                              'text': messageText,
                              'timestamp': Timestamp.now(),
                            });
                          },
                          color: Colors.blueGrey,
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  const MessagesStream({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .doc(id)
          .collection("$id-${loggedInuser!.uid}")
          // Sort the messages by timestamp DESC because we want the newest messages on bottom.
          .orderBy("timestamp", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        // If we do not have data yet, show a progress indicator.
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // Create the list of message widgets.

        // final messages = snapshot.data.documents.reversed;
        List<Widget> messageWidgets = snapshot.data!.docs.map<Widget>((m) {
          final data = m.data() as dynamic;
          final messageText = data['text'];
          final messageSender = data['sender'];
          final currentUser = loggedInuser!.uid;
          final timeStamp = data['timestamp'];
          return MessageBubble(
            sender: messageSender,
            text: messageText,
            timestamp: timeStamp,
            isMe: currentUser == messageSender,
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageWidgets,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key, this.sender, this.text, this.timestamp, this.isMe});
  final String? sender;
  final String? text;
  final Timestamp? timestamp;
  final bool? isMe;

  @override
  Widget build(BuildContext context) {
    final dateTime =
        DateTime.fromMillisecondsSinceEpoch(timestamp!.seconds * 1000);
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe!
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe! ? Colors.grey[50] : Colors.yellow[50],
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment:
                    isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    text!,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black54,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      // ignore: unnecessary_string_interpolations
                      "${DateFormat('h:mm a').format(dateTime)}",
                      style: TextStyle(
                        fontSize: 9.0,
                        color: Colors.black54.withOpacity(0.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

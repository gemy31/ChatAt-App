import 'package:chat/providers/user_provider.dart';
import 'package:chat/ui/chat/chat_navigator.dart';
import 'package:chat/ui/chat/chat_screen_view_model.dart';
import 'package:chat/utils.dart' as utils;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/message.dart';
import '../../model/room.dart';
import 'chat_message_item.dart';

class ChatScreen extends StatefulWidget {
  static String routeName = 'chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> implements ChatNavigator {
  ChatScreenViewModel viewModel = ChatScreenViewModel();
  String messageContent = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as Room;
    var userProvider = Provider.of<UserProvider>(context);
    viewModel.room = args;
    viewModel.currentUser = userProvider.user;
    viewModel.updateMessages();
    return ChangeNotifierProvider(
        create: (context) => viewModel,
        child: Stack(children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/bg.png',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(args.title),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      child: StreamBuilder<QuerySnapshot<Message>>(
                        stream: viewModel.streamMessage,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text(snapshot.error.toString()));
                          }
                          var messages = snapshot.data?.docs
                              .map((doc) => doc.data())
                              .toList();
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return MessageItem(
                                message: messages![index],
                              );
                            },
                            itemCount: messages?.length ?? 0,
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 5,
                          controller: controller,
                          onChanged: (text) {
                            messageContent = text;
                          },
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(4),
                              hintText: 'Type a message',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 0,
                                    style: BorderStyle.none),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(14),
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.sendMessage(messageContent);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                          ),
                          child: Row(
                            children: const [
                              Text('Send'),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(Icons.send),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ]));
  }

  @override
  void showMessage(String message) {
    utils.showMessage(context, message, 'Ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void clearMessage() {
    controller.clear();
  }
}

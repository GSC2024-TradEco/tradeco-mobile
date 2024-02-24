import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zero_waste_application/controllers/message.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage(
      {super.key, required this.userDisplayName, required this.userId});
  final String userDisplayName;
  final int userId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ScrollController _scrollController = ScrollController();
  bool onLoading = true;
  MessageController messageController = MessageController();
  TextEditingController textMessageController = TextEditingController();
  List<Map<String, dynamic>> messageList = [];
  // IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    // connectToSocketServer();
    _fetchMessages();
  }

  // Future<void> connectToSocketServer() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? senderId = prefs.getString('_id');

  //   socket = IO.io('ws://10.0.2.2:8800', <String, dynamic>{
  //     'transports': ['websocket'],
  //   });

  //   socket!.onConnect((_) {
  //     print('Socket connected');
  //     socket!.emit('new-user-add', senderId);
  //   });

  //   socket!.onDisconnect((_) {
  //     print('Socket disconnected');
  //   });

  //   socket!.on('receive-message', (newMessage) {
  //     Map<String, dynamic> messageData = Map<String, dynamic>.from(newMessage);

  //     String text = messageData['text'] as String;
  //     String createdAt = timeago.format(DateTime.now());
  //     String isCurrentUser =
  //         messageData['senderId'] == prefs.getString('_id') ? 'true' : 'false';

  //     Map<String, String> messageMap = {
  //       'text': text,
  //       'createdAt': createdAt,
  //       'isCurrentUser': isCurrentUser,
  //     };

  //     if (mounted) {
  //       setState(() {
  //         messageList.add(messageMap);
  //       });
  //     }
  //   });
  // }

  Future<void> _fetchMessages() async {
    try {
      setState(() {
        onLoading = true;
      });
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? messages =
          await messageController.getAllMessages(widget.userId, token!);
      setState(() {
        messageList.clear(); // Clear existing messages
        if (messages != null) {
          for (dynamic message in messages) {
            messageList.add(message);
          }
        }
        onLoading = false;
      });
    } catch (e) {
      setState(() {
        onLoading = false;
      });
    }
  }

  Future<void> sendMessage(int userId, String text) async {
    String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
    Map<String, dynamic>? message =
        await messageController.createOneMessage(userId, text, token!);
    setState(() {
      messageList.add(message!);
    });
  }

  // @override
  // void dispose() {
  //   socket?.disconnect(); // Disconnect the socket when the widget is disposed
  //   super.dispose();
  // }

  String _formatDateTime(String dateTimeString) {
    String formattedString =
        dateTimeString.replaceAll(RegExp(r' [+-]\d{4}$'), '');
    DateTime dateTime = DateTime.parse(formattedString);
    dateTime = dateTime.toLocal();
    return DateFormat.yMMMMd().add_jms().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userDisplayName),
        backgroundColor: Color(0xFF98D19B),
      ),
      body: Column(
        children: [
          Expanded(
            child: onLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    controller:
                        _scrollController, // Attach the ScrollController
                    reverse: false,
                    itemCount: messageList.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      final message = messageList[index];
                      final text = message['text'];
                      final created = _formatDateTime(message['createdAt']);
                      final image = message['image'];
                      final senderId = message['Sender']?['id'];
                      final isCurrentUser = senderId != widget.userId;

                      return Align(
                        alignment: isCurrentUser
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isCurrentUser
                                ? Color(0xFF98D19B)
                                : Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                text!,
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              image != null
                                  ? Image.network(
                                      image!,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(height: 4),
                              Text(
                                created,
                                style: TextStyle(
                                  color: isCurrentUser
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.transparent,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textMessageController,
                    decoration: InputDecoration(
                      hintText: 'Enter your message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    String textMessage = textMessageController.text.trim();
                    if (textMessage.isNotEmpty) {
                      sendMessage(widget.userId, textMessage);
                    }
                    textMessageController.text = "";
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: Color(0xFF98D19B),
                  ),
                  child: const Text(
                    'SEND',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

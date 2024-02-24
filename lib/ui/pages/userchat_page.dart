import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zero_waste_application/controllers/message.dart';
import 'package:zero_waste_application/ui/pages/message_page.dart';

class UserChatPage extends StatefulWidget {
  const UserChatPage({Key? key}) : super(key: key);

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  MessageController messageController = MessageController();
  late Future<List<dynamic>> _fetchUserChatsFuture;

  @override
  void initState() {
    super.initState();
    _fetchUserChatsFuture = _fetchUserChats();
  }

  Future<List<dynamic>> _fetchUserChats() async {
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? chats = await messageController.getUserChats(token!);
      return chats ?? [];
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Refresh method to reload posts
  Future<void> _refreshUserChats() async {
    setState(() {
      _fetchUserChatsFuture = _fetchUserChats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshUserChats,
        child: FutureBuilder(
          future: _fetchUserChatsFuture,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> userChats = snapshot.data ?? [];
              return ListView.builder(
                itemCount: userChats.length,
                itemBuilder: (context, index) {
                  final userChat = userChats[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.account_circle),
                    ),
                    title: Text(userChat['Sender']
                        ['displayName']), // Display sender's display name
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            userDisplayName: userChat['Sender']['displayName'],
                            userId: userChat['Sender']['id'],
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

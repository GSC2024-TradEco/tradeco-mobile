import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zero_waste_application/controllers/post.dart';
import 'package:zero_waste_application/models/post.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  PostController postController = PostController();
  bool onLoading = false;
  List<Map<String, dynamic>> postList = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      setState(() {
        onLoading = true;
      });
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? posts = await postController.getAllPosts(token!);
      setState(() {
        if (posts != null) {
          for (dynamic post in posts) {
            postList.add(post);
          }
        }
        onLoading = false;
      });
    } catch (e) {
      setState(() {
        onLoading = false;
      });
      print("Error fetching posts: $e");
    }
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDateTime = DateFormat.yMMMMd().add_jms().format(dateTime);
    return formattedDateTime;
  }

  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final post = postList[index];
        final user = post['User'];
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 44),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user['displayName']),
                          Text(_formatDateTime(
                              post['createdAt'])), // Format the datetime
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the title with a larger font size and bold style
                        Text(
                          post['title'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Display the description
                        Text(
                          post['description'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        // Use post['image'] if it's not null, otherwise don't display an image
                        post['image'] != null
                            ? Image.network(post['image'])
                            : SizedBox
                                .shrink(), // This will create an empty SizedBox
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 4);
      },
      itemCount: postList.length,
    );
  }
}

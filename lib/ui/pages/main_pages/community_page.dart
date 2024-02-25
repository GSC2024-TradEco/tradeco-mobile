import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zero_waste_application/controllers/post.dart';
import 'package:zero_waste_application/ui/pages/newpost_page.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  PostController postController = PostController();
  late Future<List<dynamic>> _fetchPostsFuture;

  @override
  void initState() {
    super.initState();
    _fetchPostsFuture = _fetchPosts();
  }

  Future<List<dynamic>> _fetchPosts() async {
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? posts = await postController.getAllPosts(token!);
      return posts ?? [];
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  String _formatDateTime(String dateTimeString) {
    String formattedString =
        dateTimeString.replaceAll(RegExp(r' [+-]\d{4}$'), '');
    DateTime dateTime = DateTime.parse(formattedString);
    dateTime = dateTime.toLocal();
    return DateFormat.yMMMMd().add_jms().format(dateTime);
  }

  // Refresh method to reload posts
  Future<void> _refreshPosts() async {
    setState(() {
      _fetchPostsFuture = _fetchPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => _refreshPosts(),
        child: FutureBuilder(
          future: _fetchPostsFuture,
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<dynamic> postList = snapshot.data ?? [];
              return Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewPostPage(),
                        ),
                      );
                      if (result == true) {
                        _refreshPosts();
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add), // Add your desired icon here
                        SizedBox(
                            width:
                                5), // Add some spacing between the icon and text
                        Text('Add New Post'),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
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
                                      const Icon(Icons.account_circle,
                                          size: 44),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(user['displayName'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          Text(_formatDateTime(
                                              post['createdAt'])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post['title'],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          post['description'],
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        post['image'] != null
                                            ? Image.network(post['image'])
                                            : const SizedBox.shrink(),
                                        const SizedBox(height: 5),
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
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

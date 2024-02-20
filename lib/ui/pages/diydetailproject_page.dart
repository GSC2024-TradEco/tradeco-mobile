import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:zero_waste_application/controllers/bookmark.dart';
import 'package:zero_waste_application/controllers/project.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyDetailProject extends StatefulWidget {
  const DiyDetailProject({Key? key, required this.projectId}) : super(key: key);
  final int projectId;

  @override
  State<DiyDetailProject> createState() => _DiyDetailProjectState();
}

class _DiyDetailProjectState extends State<DiyDetailProject> {
  ProjectController projectController = ProjectController();
  BookmarkController bookmarkController = BookmarkController();
  bool onLoading = true;
  bool bookmarked = false;
  Map<String, dynamic>? project;

  @override
  void initState() {
    super.initState();
    _fetchProject();
  }

  Future<void> _fetchProject() async {
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      Map<String, dynamic>? fetchedProject =
          await projectController.getOneProject(widget.projectId, token!);
      setState(() {
        project = fetchedProject;
        if (project!['bookmarked'] != null) {
          bookmarked = true;
        }
        onLoading = false; // Set loading to false after fetching the project
      });
    } catch (e) {
      setState(() {
        onLoading = false; // Set loading to false in case of error
      });
    }
  }

  Future<void> _toggleBookmarkProject(int projectId) async {
    try {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      if (bookmarked) {
        // If already bookmarked, remove the bookmark
        bool success =
            await bookmarkController.deleteOneBookmark(projectId, token!);
        if (success) {
          setState(() {
            bookmarked = false;
            onLoading = false;
          });
        }
      } else {
        // If not bookmarked, add the bookmark
        Map<String, dynamic>? bookmarkedProject =
            await bookmarkController.createOneBookmark(projectId, token!);
        if (bookmarkedProject != null) {
          setState(() {
            bookmarked = true;
            onLoading = false;
          });
        }
      }
    } catch (e) {
      setState(() {
        onLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project?['title'] ?? ''),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () async {
              // Implement save or bookmark functionality
              await _toggleBookmarkProject(project!['id']);
            },
            icon: bookmarked
                ? const Icon(Icons.bookmark_added)
                : const Icon(Icons.bookmark_border),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: CustomTheme.color.gradientBackground1,
          ),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: !onLoading, // Show the content when not loading
              child: SingleChildScrollView(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    image: const DecorationImage(
                      image: AssetImage(
                        "assets/images/backgrounds/Saved Project.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  padding: const EdgeInsets.all(17),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: project != null && project!['image'] != null
                            ? Image.network(project!['image'])
                            : const SizedBox.shrink(),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        project?['description'] ?? "No description available",
                      ),
                      const SizedBox(height: 26),
                      Text(
                        "Here's a tutorial to help you make it come true!",
                      ),
                      const SizedBox(height: 13),
                      // Clickable URL
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse(project!['reference']);
                          await launchUrl(url);
                        },
                        child: Text(
                          project!['reference'],
                          style: TextStyle(
                            color:
                                Colors.blue, // Change color as per your design
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      if (project?['materials'] != null &&
                          project?['materials'].isNotEmpty)
                        Column(
                          children: [
                            Text(
                              "Materials Needed:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 13),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: project!['materials'].length,
                              itemBuilder: (context, index) {
                                var material = project!['materials'][index];
                                return ExpansionTile(
                                  title: Text(material),
                                  children: [
                                    if (project!['missingMaterials'] != null &&
                                        project!['missingMaterials']
                                            .contains(material)) ...[
                                      Text(
                                        "You are missing this material!",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      const SizedBox(height: 8),
                                      if (project![
                                                  'usersWithMissingMaterials'] !=
                                              null &&
                                          project!['usersWithMissingMaterials']
                                              .isNotEmpty)
                                        Text(
                                          "Try contact the Users below.",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ...[
                                        for (var user in project![
                                            'usersWithMissingMaterials'])
                                          ListTile(
                                            title: Text(user['User']
                                                    ['displayName'] ??
                                                ''),
                                            subtitle: Text(
                                                user['User']['email'] ?? ''),
                                            tileColor: user['name'] == material
                                                ? Colors.green
                                                : Colors.red,
                                            // Add a divider if the user doesn't have the material
                                            trailing: user['name'] != material
                                                ? Divider(
                                                    color: Colors.black,
                                                    height: 20,
                                                    thickness: 1,
                                                  )
                                                : null,
                                          ),
                                      ],
                                    ],
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible:
                  onLoading, // Show the circular progress indicator while loading
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

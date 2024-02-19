import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool onLoading = true;
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
        onLoading = false; // Set loading to false after fetching the project
      });
    } catch (e) {
      setState(() {
        onLoading = false; // Set loading to false in case of error
      });
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project?['title'] ?? 'Title'),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: CustomTheme.color.gradientBackground1,
          ),
        ),
        child: onLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                        child: Image.asset(
                          project?['image'] ??
                              "assets/images/backgrounds/Yarn-Love-Sign_10-1.jpg.webp",
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        project?['description'] ?? "No description available",
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "What you’ll need: ${project?['materials'] ?? 'No materials provided'}",
                      ),
                      const SizedBox(height: 100),
                      if (project?['missingMaterials'] != null)
                        Column(
                          children: [
                            Text(
                              "Warning! You are missing a few items to build this, try contacting some of the users below to get them:",
                            ),
                            const SizedBox(height: 13),
                            ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: (build, index) {
                                var user = project!['usersWithMissingMaterials']
                                    [index]['User'];
                                var missingMaterial =
                                    project!['missingMaterials'][index]['name'];
                                return Container(
                                  height: 60,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: CustomTheme.color.base2,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                          "$missingMaterial by ${user['displayName'] ?? 'Unknown'}"),
                                      Expanded(child: Container()),
                                      const Icon(Icons.circle),
                                      const Icon(Icons.circle),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (build, context) {
                                return const SizedBox(height: 7);
                              },
                              itemCount:
                                  project!['usersWithMissingMaterials'].length,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/controllers/project.dart';
import 'package:zero_waste_application/ui/pages/camera_page.dart';
import 'package:zero_waste_application/ui/pages/diydetailproject_page.dart';
import 'package:zero_waste_application/ui/pages/diylistitem_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyPage extends StatefulWidget {
  const DiyPage({super.key, required this.cam});
  final CameraDescription cam;
  @override
  State<DiyPage> createState() => _DiyPageState();
}

class _DiyPageState extends State<DiyPage> {
  ProjectController projectController = ProjectController();
  bool onLoading = false;
  List<dynamic> projectList = [];

  @override
  void initState() {
    super.initState();
    _fetchAllProjects();
  }

  Future<void> _fetchAllProjects() async {
    try {
      setState(() {
        onLoading = true;
      });
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      print(token);
      List<dynamic>? projects = await projectController.getAllProjects(token!);
      print('projects ${projects}');
      setState(() {
        if (projects != null) {
          for (dynamic project in projects) {
            projectList.add(project);
          }
        }
        print('success');
        print(projects);
        onLoading = false;
      });
    } catch (e) {
      setState(() {
        onLoading = false;
      });
      print("Error fetching wastes: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Expanded(
        child: Column(
          children: [
            Text(
              'Upcycle your waste, ignite your creativity!',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: CustomTheme.fontWeight.light,
                ),
              ),
            ),
            Text(
              'Your trash, your treasure.',
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: CustomTheme.fontWeight.bold,
                  color: CustomTheme.color.base1,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => NewDiyPage(cam: widget.cam),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    height: 120,
                    width: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons/scan.png",
                          width: 38,
                          height: 38,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "Scan Wastes",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: CustomTheme.fontWeight.regular,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => DiyListItem(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    height: 120,
                    width: 85,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/icons/items.png",
                          width: 38,
                          height: 38,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "My Wastes",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: CustomTheme.fontWeight.regular,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All DIY Projects",
                        style: GoogleFonts.robotoSlab(
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: CustomTheme.fontWeight.regular,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: onLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : projectList.isEmpty
                            ? Text('No projects available.')
                            : GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: (1 / 1.25),
                                children: List.generate(
                                  projectList.length,
                                  (index) {
                                    var project = projectList[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (builder) =>
                                                DiyDetailProject(
                                                    projectId: project['id']),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(5),
                                        padding: const EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: const DecorationImage(
                                            image: AssetImage(
                                              "assets/images/backgrounds/Saved Project.png",
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Image.asset(
                                                  "assets/images/backgrounds/recycle tin.webp",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              project['title'] ??
                                                  "Untitled Project",
                                              style: GoogleFonts.robotoSlab(
                                                textStyle: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: CustomTheme
                                                      .fontWeight.regular,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

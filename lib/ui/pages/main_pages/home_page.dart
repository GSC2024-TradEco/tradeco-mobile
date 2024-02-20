import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/controllers/bookmark.dart';
import 'package:zero_waste_application/controllers/tip.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.changePage,
  });
  final changePage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BookmarkController bookmarkController = BookmarkController();
  TipController tipController = TipController();
  bool onLoading = false;
  Map<String, dynamic>? randomTips;
  List<dynamic> bookmarkedProjectList = [];

  @override
  void initState() {
    super.initState();
    _fetchRandomTips();
    _fetchBookmarkedProjects();
  }

  Future<void> _fetchBookmarkedProjects() async {
    try {
      setState(() {
        onLoading = true;
      });
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? bookmarkedProjects =
          await bookmarkController.getAllBookmarks(token!);
      setState(() {
        if (bookmarkedProjects != null) {
          for (dynamic bookmarkedProject in bookmarkedProjects) {
            bookmarkedProjectList.add(bookmarkedProject);
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

  Future<void> _fetchRandomTips() async {
    try {
      Map<String, dynamic>? fetchedRandomTips =
          await tipController.getOneTip(1);
      setState(() {
        randomTips = fetchedRandomTips;
        onLoading = false; // Set loading to false after fetching the project
      });
    } catch (e) {
      setState(() {
        onLoading = false; // Set loading to false in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // TextField(
          //   decoration: InputDecoration(
          //     hintText: "Search",
          //     border: const UnderlineInputBorder(
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //     ),
          //     fillColor: CustomTheme.color.background1,
          //     filled: true,
          //   ),
          // ),
          const SizedBox(height: 20),
          Container(
            height: 156,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/backgrounds/Saved Project.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Random Tips",
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: CustomTheme.fontWeight.regular,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (onLoading)
                        CircularProgressIndicator()
                      else if (randomTips != null)
                        Text(
                          randomTips![
                              'description'], // Assuming 'tip' is the key holding the tip content
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 13,
                              fontWeight: CustomTheme.fontWeight.regular,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 21),
          Container(
            height: 156,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/backgrounds/Saved Project.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Saved Project",
                  style: GoogleFonts.robotoSlab(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: CustomTheme.fontWeight.regular,
                    ),
                  ),
                ),
                Expanded(
                  child: onLoading
                      ? CircularProgressIndicator() // Show a loading indicator while fetching bookmarks
                      : bookmarkedProjectList.isNotEmpty
                          ? ListView.builder(
                              itemCount: bookmarkedProjectList.length,
                              itemBuilder: (context, index) {
                                // Build the list of bookmarked projects here
                                // You can customize how each bookmarked project is displayed
                                return ListTile(
                                  title: Text(
                                    bookmarkedProjectList[index].toString(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  // You can add more details or actions related to each bookmarked project
                                );
                              },
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You don't have any saved projects",
                                  style: GoogleFonts.lato(
                                    textStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          CustomTheme.fontWeight.regular,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    widget.changePage(2);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: CustomTheme.color.base1,
                                    foregroundColor:
                                        CustomTheme.color.background1,
                                  ),
                                  child: const Text("Save A Project"),
                                ),
                              ],
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

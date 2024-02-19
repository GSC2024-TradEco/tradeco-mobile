import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                  "Tips Of The Day",
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
                      Text(
                        "Sleep Good Live Good",
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You don't have any saved projects",
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
                ElevatedButton(
                  onPressed: () {
                    widget.changePage(2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomTheme.color.base1,
                    foregroundColor: CustomTheme.color.background1,
                  ),
                  child: const Text("Save A Project"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

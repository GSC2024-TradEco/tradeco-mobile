import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/ui/pages/diydetailproject_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyListProject extends StatefulWidget {
  const DiyListProject({super.key});

  @override
  State<DiyListProject> createState() => _DiyListProjectState();
}

class _DiyListProjectState extends State<DiyListProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: CustomTheme.color.gradientBackground1,
          ),
        ),
        padding: EdgeInsets.only(
          top: 46,
          left: 12,
          right: 12,
        ),
        child: Column(
          children: [
            Text(
              "Based on the given items, here are some projects you can try:",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: CustomTheme.fontWeight.regular,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.25),
                children: List.generate(
                  10,
                  (index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => DiyDetailProject(),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
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
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  "assets/images/backgrounds/recycle tin.webp",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Recycle Cookie Tins",
                              style: GoogleFonts.robotoSlab(
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: CustomTheme.fontWeight.regular,
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
      ),
    );
  }
}

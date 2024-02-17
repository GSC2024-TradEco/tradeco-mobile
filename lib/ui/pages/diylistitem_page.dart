import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/ui/pages/diylistproject_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyListItem extends StatefulWidget {
  const DiyListItem({super.key});

  @override
  State<DiyListItem> createState() => _DiyListItemState();
}

class _DiyListItemState extends State<DiyListItem> {
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
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              "Item Found",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: CustomTheme.fontWeight.regular,
                ),
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Container(
                    height: 70,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: CustomTheme.color.base1,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cardboard Box",
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: CustomTheme.fontWeight.regular,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.cancel_presentation_outlined),
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
                itemCount: 10,
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => DiyListProject(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: CustomTheme.color.base2,
                foregroundColor: Colors.black,
              ),
              child: SizedBox(
                width: 148,
                height: 44,
                child: Center(
                  child: Text(
                    "Next",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: CustomTheme.fontWeight.medium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Settings"),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 34),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: CustomTheme.color.gradientBackground1,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage(
                  "assets/images/backgrounds/plant.png",
                ),
              ),
              const SizedBox(height: 17),
              Text(
                "aldifahluzi",
                style: GoogleFonts.robotoSlab(
                  textStyle: TextStyle(
                    fontSize: 25,
                    fontWeight: CustomTheme.fontWeight.regular,
                  ),
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  const SizedBox(width: 23),
                  Text(
                    "My Contacts",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: CustomTheme.fontWeight.regular,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 70,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 30,
                      ),
                      decoration:
                          BoxDecoration(color: CustomTheme.color.background2),
                      child: Row(
                        children: [
                          Icon(Icons.contact_emergency),
                          SizedBox(width: 5),
                          Text(
                            "socialmedia username",
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: CustomTheme.fontWeight.light,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 3);
                  },
                  itemCount: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: CustomTheme.color.base2,
                      foregroundColor: Colors.black,
                    ),
                    child: const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text("Delete Account"),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: CustomTheme.color.base2,
                      foregroundColor: Colors.black,
                    ),
                    child: const SizedBox(
                      width: 100,
                      child: Center(
                        child: Text("Logout"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyDetailProject extends StatefulWidget {
  const DiyDetailProject({super.key});

  @override
  State<DiyDetailProject> createState() => _DiyDetailProjectState();
}

class _DiyDetailProjectState extends State<DiyDetailProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
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
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
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
                  "assets/images/backgrounds/Yarn-Love-Sign_10-1.jpg.webp",
                ),
              ),
              const SizedBox(height: 26),
              Text(
                "If you are looking for a fun project to do while sitting on the sofa, this yarn art is it. Make yarn wall art out of any word using cardboard and simple wrapping!",
              ),
              const SizedBox(height: 13),
              Text(
                "What you’ll need: Piece of cardboard, scissors/X-acto knife, marker, tape, yarn",
              ),
              const SizedBox(height: 13),
              Text(
                "Warning! You are missing a few items to build this, try contacting some of the users below to get them:",
              ),
              const SizedBox(height: 13),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (build, context) {
                    return Container(
                      height: 60,
                      width: double.infinity,
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.all(3),
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
                          Text("Yarn"),
                          Expanded(child: Container()),
                          Icon(Icons.circle),
                          Icon(Icons.circle),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (build, context) {
                    return const SizedBox(height: 7);
                  },
                  itemCount: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

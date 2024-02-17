import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
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
                children: [
                  const Row(
                    children: [
                      Icon(Icons.person, size: 44),
                      Column(
                        children: [
                          Text("Aldi Fahluzi"),
                          Text("4 mins ago"),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("I just create something new.."),
                        SizedBox(height: 5),
                        Image.asset(
                            "assets/images/backgrounds/plant funny.jpg"),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.thumb_up_alt_outlined),
                            Text("15"),
                            Icon(Icons.comment_outlined),
                            Text("15")
                          ],
                        )
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
      itemCount: 10,
    );
  }
}

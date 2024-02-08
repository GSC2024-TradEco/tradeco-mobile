import 'package:flutter/material.dart';
import 'package:zero_waste_application/ui/pages/tipsandtrick_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: "Search")),
          Container(
            height: 154,
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Tips or Tricks"),
                    InkWell(
                      onTap: () {
                        print('tap');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TipsAndTrickPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 9),
                SizedBox(
                  height: 97,
                  width: double.infinity,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: 3,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 12);
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        height: 97,
                        width: 143,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("DIY Recommendations"),
                      InkWell(
                        onTap: () {
                          print('tap');
                        },
                        child: const Text(
                          "See All",
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 9),
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView.separated(
                        itemCount: 10,
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 12);
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            height: 97,
                            width: 143,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black)),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

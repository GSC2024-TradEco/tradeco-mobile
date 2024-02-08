import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TipsAndTrickPage extends StatefulWidget {
  const TipsAndTrickPage({super.key});

  @override
  State<TipsAndTrickPage> createState() => _TipsAndTrickPageState();
}

class _TipsAndTrickPageState extends State<TipsAndTrickPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tips & Tricks"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              children: [
                Expanded(
                  child: Container(
                    height: 127,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text("Tricks Name"),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: Container(
                    height: 127,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text("Tricks Name"),
                  ),
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
          itemCount: 10,
        ),
      ),
    );
  }
}

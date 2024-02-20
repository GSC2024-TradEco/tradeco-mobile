// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_waste_application/controllers/waste.dart';
import 'package:zero_waste_application/ui/pages/diylistproject_page.dart';
import 'package:zero_waste_application/ui/styles/custom_theme.dart';

class DiyListItem extends StatefulWidget {
  const DiyListItem({super.key, this.itemFromCamera});
  final itemFromCamera;

  @override
  State<DiyListItem> createState() => _DiyListItemState();
}

class _DiyListItemState extends State<DiyListItem> {
  TextEditingController wasteNameController = TextEditingController();
  WasteController wasteController = WasteController();
  bool onLoading = false;
  List<dynamic> wasteList = [];

  @override
  void initState() {
    super.initState();
    _fetchWasteFromCamera().whenComplete(() {
      _fetchWastes();
    });
  }

  Future<void> _fetchWasteFromCamera() async {
    setState(() {
      onLoading = true;
    });
    if (widget.itemFromCamera != null) {
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      for (var item in widget.itemFromCamera) {
        Map<String, dynamic>? waste =
            await wasteController.createOneWaste(item['tag'].trim(), token!);
        wasteList.add(waste);
      }
    }
    setState(() {
      onLoading = false;
    });
  }

  Future<void> _fetchWastes() async {
    try {
      setState(() {
        onLoading = true;
      });
      String? token = await FirebaseAuth.instance.currentUser!.getIdToken(true);
      List<dynamic>? wastes = await wasteController.getAllWastes(token!);
      setState(() {
        wasteList.clear(); // Clear existing wastes
        if (wastes != null) {
          for (dynamic waste in wastes) {
            wasteList.add(waste);
          }
        }
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
            const SizedBox(height: 20),
            Text(
              "My Wastes",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: CustomTheme.fontWeight.regular,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: onLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator()) // Show loading indicator while fetching
                  : wasteList.isEmpty
                      ? const Center(
                          child: Text(
                              'Your waste list is empty, try adding or scan your wastes to get DIY project suggestion')) // Show message if the list is empty
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            final waste = wasteList[index];
                            return Container(
                              height: 70,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: CustomTheme.color.base1,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    waste[
                                        'name'], // Use the name field from the waste object
                                    style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight:
                                            CustomTheme.fontWeight.regular,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      String? token = await FirebaseAuth
                                          .instance.currentUser!
                                          .getIdToken(true);
                                      bool success = await wasteController
                                          .deleteOneWaste(waste['id'], token!);
                                      if (success) {
                                        // Show dialog to confirm deletion
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Waste Deleted'),
                                              content: const Text(
                                                  'The waste has been successfully deleted.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text('OK'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                        // Refresh the waste list after deletion
                                        _fetchWastes();
                                      }
                                    },
                                    child: const Icon(
                                        Icons.cancel_presentation_outlined),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(height: 5);
                          },
                          itemCount:
                              wasteList.length, // Use the length of wasteList
                        ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: wasteNameController,
                      decoration: const InputDecoration(
                        label: Text('Enter Waste Name'),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      String? token = await FirebaseAuth.instance.currentUser!
                          .getIdToken(true);
                      Map<String, dynamic>? waste =
                          await wasteController.createOneWaste(
                              wasteNameController.text.trim(), token!);
                      if (waste != null) {
                        setState(() {
                          wasteList.add(waste);
                          _fetchWastes();
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Waste Added'),
                              content: const Text(
                                  'The waste has been successfully added.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      wasteNameController.text = "";
                    },
                    child: const Text('Add Waste'),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                List<String> wasteNames = wasteList
                    .map((waste) => waste['name'] as String)
                    .toList(); // Convert elements to String
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => DiyListProject(
                      wasteNames: wasteNames,
                    ), // Pass the list of waste names
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
                width: 158,
                height: 44,
                child: Center(
                  child: Text(
                    "Find Project Suggestions",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: CustomTheme.fontWeight.medium,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

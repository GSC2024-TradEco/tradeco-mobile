import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile Settings")),
      body: Container(
        padding: EdgeInsets.all(34),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                child: Icon(Icons.person),
              ),
              SizedBox(height: 30),
              Text("username"),
              SizedBox(height: 35),
              Text("My Contacts"),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      height: 33,
                      child: Row(
                        children: [
                          Icon(Icons.contact_emergency),
                          SizedBox(width: 5),
                          Text("socialmedia username"),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: 10,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Delete Account"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Sign Out"),
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

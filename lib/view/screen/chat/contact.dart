
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zippo/constants.dart';
import 'package:zippo/view/screen/chat/chat_page.dart';


class ContactScreen extends StatefulWidget {
  ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact")),
      body: _buildUserList(),
    );
  }

  //build a list of user except current login user
  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }

        return ListView(
          children: snapshot.data!.docs
              .map<Widget>((doc) => _buildUserListItem(doc))
              .toList(),
        );
      },
    );
  }

  //build individual user list items
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    //display all users except current user
    if (firebaseAuth.currentUser!.email != data['email']) {
      // return ListTile(
      //   title: Text(data['name']),
      //   onTap: () {
      //     //pass the clicked user's uid to the chat page
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ChatPage(
          //               receiveruserEmail: data['email'],
          //               recieverUserID: data['uid'],
          //             )));
      //   },
      // );
      return Container(
      padding: EdgeInsets.only(top: 15, left: 15, right: 15),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                    photoUrl: data['profilePhoto'],
                        receiverusername: data['name'],
                        recieverUserID: data['uid'],
                      )));
        },
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.only(top: 0, left: 0, right: 15),
                  child: SizedBox(
                    width: 54,
                    height: 54,
                    child: CachedNetworkImage(imageUrl: "${data['profilePhoto']}"),
                  )),
              Container(
                width: 250,
                padding: EdgeInsets.only(
                    top: 15, left: 0, right: 0, bottom: 0),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Color(0xffe5ef5)))),
                child: Row(
                  children: [
                    SizedBox(
                      width: 200,
                      height: 42,
                      child: Text(
                        data['name'] ?? "",
                        style: TextStyle(
                            fontFamily: "Avenir",
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color.fromARGB(255, 45, 45, 47)),
                      ),
                    )
                  ],
                ),
              )
            ]),
      ),
    );
    } else {
      return Container();
    }
  }
}

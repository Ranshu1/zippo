import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zippo/constants.dart';
import 'package:zippo/services/chat/chat_service.dart';
import 'package:zippo/view/screen/chat/chat_bubble.dart';
import 'package:zippo/view/screen/widgets/text_input_field.dart';

class ChatPage extends StatefulWidget {
  final String receiverusername;
  final String recieverUserID;
  final String photoUrl;
  ChatPage(
      {Key? key,
      required this.receiverusername,
      required this.recieverUserID,
      required this.photoUrl})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  ScrollController msgScrolling = ScrollController();
  FocusNode contectNode = FocusNode();
  final TextEditingController _messageController = TextEditingController();
  final Chatservice _chatService = Chatservice();
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverUserID, _messageController.text);
      //clear the text controllre after  sending the message
      _messageController.clear();
    }
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      elevation: 0,
      flexibleSpace: Container(
          decoration: const BoxDecoration(
              color: Colors.blueGrey)),
      title: Row(children: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        Container(
          padding: EdgeInsets.only(top: 0, bottom: 0, right: 0),
          child: InkWell(
            child: SizedBox(
              width: 44,
              height: 44,
              child: CachedNetworkImage(
                imageUrl: widget.photoUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: 44,
                  width: 44,
                  margin: null,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(44)),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                errorWidget: (context, url, error) => const Image(
                    image: NetworkImage('https://www.alleganyco.gov/wp-content/uploads/unknown-person-icon-Image-from.png')),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 180,
          padding: EdgeInsets.only(top: 25, bottom: 0, right: 0),
          child: Row(children: [
            SizedBox(
              width: 180,
              height: 44,
              child: GestureDetector(
                onTap: () {},
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.receiverusername,
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
            )
          ]),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(children: [
        //message
        Expanded(child: _buildMessageList()),
        //user input
        _buildMessageInput(),
        SizedBox(
          height: 25,
        )
      ]),
      // body: SafeArea(
      //   child: ConstrainedBox(
      //     constraints: const BoxConstraints.expand(),
      //     child: Stack(
      //       children: [
      //         _buildMessageList(),
      //         Positioned(
      //           bottom: 0,
      //           height: 50,
      //           child: Container(
      //             padding: EdgeInsets.only(left: 10),
      //             width: 360,
      //             height: 50,
      //             color: Color.fromARGB(255, 255, 255, 255),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: [
      //                 SizedBox(
      //                   width: 217,
      //                   height: 50,
      //                   child: TextField(
      //                     keyboardType: TextInputType.multiline,
      //                     maxLines: 3,
      //                     controller: _messageController,
      //                     autofocus: false,
      //                     decoration: const InputDecoration(
      //                         hintText: "Send messages..."),
      //                   ),
      //                 ),
      //                 Container(
      //                   height: 30,
      //                   width: 30,
      //                   margin: EdgeInsets.only(left: 5),
      //                   child: GestureDetector(
      //                     child: Icon(
      //                       Icons.photo_outlined,
      //                       size: 35,
      //                       color: Colors.blue,
      //                     ),
      //                     onTap: () {
      //                       _showPicker(context);
      //                     },
      //                   ),
      //                 ),
      //                 Container(
      //                   margin: EdgeInsets.only(left: 10, top: 5),
      //                   width: 65,
      //                   height: 35,
      //                   child: ElevatedButton(
      //                     child: Text("send"),
      //                     onPressed: () {
      //                       sendMessage();
      //                     },
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.recieverUserID, firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          controller: msgScrolling,
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
        

      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //align the message to the right if the sender is the current user, otherwise to the left
    var aligment = (data['senderId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: aligment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment:
                (data['senderId'] == firebaseAuth.currentUser!.uid)
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
            mainAxisAlignment:
                (data['senderId'] == firebaseAuth.currentUser!.uid)
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              (data['senderId'] == firebaseAuth.currentUser!.uid)
                  ? Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue,
                      ),
                      child: Text(
                        data['message'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.green,
                      ),
                      child: Text(
                        data['message'],
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    )
            ]),
      ),
    );
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: [
          //textfield
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              controller: _messageController,
              autofocus: false,
              focusNode: contectNode,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Send messages..."),
            ),
          ),
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(left: 5),
            child: GestureDetector(
              child: Icon(
                Icons.photo_outlined,
                size: 35,
                color: Colors.blue,
              ),
              onTap: () {
                _showPicker(context);
              },
            ),
          ),

          //send button
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.arrow_upward,
                size: 40,
              ))
        ],
      ),
    );
  }

  //pick image
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text("Gallery"),
                  onTap: () {
                    ImagePicker().pickImage(source: ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text("Camera"),
                  onTap: () {
                    ImagePicker().pickImage(source: ImageSource.camera);
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    msgScrolling.dispose();
    super.dispose();
  }
}

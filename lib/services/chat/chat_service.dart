import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zippo/constants.dart';
import 'package:zippo/models/message.dart';

class Chatservice extends GetxController {
  //send message
  Future<void> sendMessage(String recieverId, String message) async {
    //get current user info
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentUserEmail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        receiverId: recieverId,
        message: message,
        timestamp: timestamp);

    //construt chat room id from current user id and reciever id (soted to ensure uniqueness)
    List<String> ids = [currentUserId, recieverId];
    ids.sort(); // sort the ids(this ensures the chat room id is always the same for any pair of people)
    String chatRoomId = ids.join(
        "_"); //combine the ids into  a single string to use as a chatroomId

    //add new message to database
    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    //construct chat room id from ids(sorted to ensure it matches the id used when sending messages)
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false).snapshots();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:zippo/controller/authController.dart';
import 'package:zippo/view/screen/add_video_screen.dart';
import 'package:zippo/view/screen/chat/contact.dart';
import 'package:zippo/view/screen/profile_screen.dart';
import 'package:zippo/view/screen/search_screen.dart';
import 'package:zippo/view/screen/video_screen.dart';

List pages = [
  VideoScreen(),
  SearchScreen(),
  const AddVideoScreen(),
  ContactScreen(),
  ProfileScreen(uid: authController.user.uid),
];

//Colors
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLER
var authController = AuthController.instance;

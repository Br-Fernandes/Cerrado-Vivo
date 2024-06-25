//PÁGINAS PRINCIPAIS
import 'package:cerrado_vivo/controllers/auth_controller.dart';
import 'package:cerrado_vivo/views/pages/content_home.dart';
import 'package:cerrado_vivo/views/pages/conversations_page.dart';
import 'package:cerrado_vivo/views/pages/mine_page.dart';
import 'package:cerrado_vivo/views/pages/promote_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

List mainPages = [
  const ContentHomePage(),
  MinePage(),
  const PromotePage(),
  const ConversationsPage(),
];

// FIREBASE
var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

//CONTROLLERS
var authController = AuthController.instance;

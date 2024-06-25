// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserApp {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final Rx<String> bio;
  final Rx<String> location;

  UserApp({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    String? userBio,
    String? userLocation,
  })  : bio = Rx<String>(userBio ?? ''),
        location = Rx<String>(userLocation ?? '');

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'imageUrl': imageUrl,
        'bio': bio.value,
        'location': location.value
      };

  UserApp fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserApp(
        id: snap['id'],
        name: snap['name'],
        email: snap['email'],
        imageUrl: snap['imageUrl'] ?? 'assets/images/avatar.png',
        userBio: snap['bio'] ?? '',
        userLocation: snap['location'] ?? '');
  }
}

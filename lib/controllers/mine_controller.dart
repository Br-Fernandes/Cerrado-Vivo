import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MineController extends GetxController {
  editBio(String bio) {
    String userId = authController.currentUser!.id;
    DocumentReference docRef = firestore.collection('users').doc(userId);

    Map<String, dynamic> data = {
      'bio': bio
    };

    docRef.update(data).then((value) => print('Bio atualizada'));
  }

}


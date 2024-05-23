import 'dart:io';

import 'package:flutter/material.dart';

class MessageBubbleViewModel extends ChangeNotifier {

  static const String  _defaultImage = 'assets/images/avatar.png';

  String get defaultImage => _defaultImage;

  ImageProvider getImageProvider(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }
    return provider;
  }
  
}
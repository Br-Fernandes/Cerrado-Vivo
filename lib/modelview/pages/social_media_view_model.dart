import 'package:cerrado_vivo/views/pages/conversations_page.dart';
import 'package:cerrado_vivo/views/pages/promote_page.dart';
import 'package:cerrado_vivo/views/pages/trade_page.dart';
import 'package:flutter/material.dart';

class SocialMediaViewModel extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  List<Widget> get pages => [
        const TradePage(),
        const PromotePage(),
        const ConversationsPage(),
      ];

  void onTappedItem(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}

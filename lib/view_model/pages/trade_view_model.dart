import 'package:cerrado_vivo/models/chat_user.dart';
import 'package:cerrado_vivo/models/product.dart';
import 'package:cerrado_vivo/services/trade/trade_service.dart';
import 'package:cerrado_vivo/utils/chat_utils.dart';
import 'package:flutter/material.dart';

class TradeViewModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ChatUser? _currentUser;
  
  ChatUser? get currentUser => _currentUser;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  List<Product> getProducts() {
    return TradeService.getProducts();
  }

  void openEndDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }


  Future<void> getCurrentUserInformations() async {
    _currentUser = await ChatUtils().getCurrentUser();
    notifyListeners();
  }
}
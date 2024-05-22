import 'package:cerrado_vivo/components/product_card.dart';
import 'package:cerrado_vivo/components/user_drawer.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/trade/trade_service.dart';
import 'package:cerrado_vivo/core/utils/chat_utils.dart';
import 'package:flutter/material.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  ChatUser? _currentUser;

  @override
  void initState() {
    super.initState();
    _getCurrentUserInformations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53AC3C),
        centerTitle: true,
        title: const Text(
          "Coletores",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          if (_currentUser != null)
            Builder(
              builder: (context) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () => Scaffold.of(context).openEndDrawer(),
                    onHorizontalDragUpdate: (details) {
                      if(details.delta.dx < 0) {
                        Scaffold.of(context).openEndDrawer();
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.keyboard_double_arrow_left_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        CircleAvatar(
                          radius: 22,
                          backgroundImage: NetworkImage(
                              _currentUser!.imageUrl),
                        ),
                      ],
                    ),
                  ),
                );
              }
            )
        ],
      ),
      endDrawer: _currentUser != null
        ? Drawer(
            child: UserDrawer(user: _currentUser!),
          )
        : null,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: TradeService.getProducts().length,
                itemBuilder: (context, index) {
                  final product = TradeService.getProducts()[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openEndDrawer() {
    Scaffold.of(context).openEndDrawer();
  }

  void _openUserDrawer() {
    if (_currentUser != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return UserDrawer(user: _currentUser!);
        },
      );
    }
  }

  Future<void> _getCurrentUserInformations() async {
    _currentUser = await ChatUtils().getCurrentUser();
    debugPrint('_currentUser: $_currentUser');
    setState(() {});
  }

}

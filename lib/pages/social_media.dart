import 'package:cerrado_vivo/pages/conversations_page.dart';
import 'package:cerrado_vivo/pages/promote_page.dart';
import 'package:cerrado_vivo/pages/trade_page.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    TradePage(),
    const PromotePage(),
    const ConversationsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!, // Cor da linha superior
              width: 1.0, // Espessura da linha
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), 
              spreadRadius: 2, 
              blurRadius: 5, 
              offset: const Offset(0, -2), 
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onTappedItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.storefront),
              label: 'Coletores',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_rounded),
              label: 'Anunciar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message_rounded),
              label: 'Conversas',
            ),
          ],
        ),
      ),
    );
  }

  void _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }  
}

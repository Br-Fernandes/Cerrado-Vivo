import 'package:cerrado_vivo/view_model/pages/social_media_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  late final SocialMediaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = SocialMediaViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Consumer<SocialMediaViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: viewModel.pages[viewModel.selectedIndex],
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
                currentIndex: viewModel.selectedIndex,
                onTap: viewModel.onTappedItem,
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
        },
      ),
    );
  }
}

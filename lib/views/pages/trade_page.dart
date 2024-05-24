import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerrado_vivo/view_model/pages/trade_view_model.dart';
import 'package:cerrado_vivo/views/components/product_card.dart';
import 'package:cerrado_vivo/views/components/user_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TradePage extends StatefulWidget {
  const TradePage({super.key});

  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  late final TradeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TradeViewModel();
    _viewModel.getCurrentUserInformations();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Consumer<TradeViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            key: viewModel.scaffoldKey,
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
                if (viewModel.currentUser != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: GestureDetector(
                      onTap: () => viewModel.openEndDrawer(),
                      onHorizontalDragUpdate: (details) {
                        if (details.delta.dx < 0) {
                          viewModel.openEndDrawer();
                        }
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.keyboard_double_arrow_left_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          CachedNetworkImage(
                            imageUrl: viewModel.currentUser!.imageUrl,
                            imageBuilder: (context, imageProvider) => CircleAvatar(
                              radius: 22,
                              backgroundImage: NetworkImage(
                                viewModel.currentUser!.imageUrl
                              ),
                            ),
                            width: 44,
                            height: 44,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(Icons.error)
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
            endDrawer: viewModel.currentUser != null
                ? Drawer(
                    child: UserDrawer(user: viewModel.currentUser!),
                  )
                : null,
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.getProducts().length,
                      itemBuilder: (context, index) {
                        final product = viewModel.getProducts()[index];
                        return ProductCard(product: product);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

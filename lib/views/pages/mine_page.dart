
import 'package:cerrado_vivo/controllers/mine_controller.dart';
import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cerrado_vivo/views/components/custom_icon.dart';
import 'package:cerrado_vivo/views/components/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  MinePage({super.key});

  final MineController mineController = Get.put(MineController());

  final SliverGridDelegate gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    crossAxisSpacing: 16.0,
    mainAxisSpacing: 16.0,
    childAspectRatio: 0.75,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: null,
              expandedHeight: MediaQuery.of(context).size.height * 0.4,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Expanded(
                  child: UserProfileHeader(
                    user: authController.currentUser!,
                    isCurrentUser: true,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: const Center(
                        child: CustomIcon(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          color: Colors.white,
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: gridDelegate,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200]
                ),
                child: Center(
                  child: Text('Item $index'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

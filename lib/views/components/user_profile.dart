import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerrado_vivo/controllers/mine_controller.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UserProfileHeader extends StatelessWidget {
  UserProfileHeader(
      {super.key, required this.isCurrentUser, required this.user});

  final bool isCurrentUser;
  final UserApp user;

  MineController mineController = MineController();

  @override
  Widget build(BuildContext context) {
    final double systemBarHeight = MediaQuery.of(context).viewPadding.top;
    final double appBarHeight = AppBar().preferredSize.height * 1.2;
    final double circleAvatarRadius = appBarHeight / 2;

    print(systemBarHeight.toString());

    return Column(
      children: [
        Stack(
          children: [
            AppBar(
              toolbarHeight: appBarHeight,
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: Text(user.name),
              centerTitle: true,
              leading: CachedNetworkImage(
                imageUrl: user.imageUrl,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: circleAvatarRadius,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                placeholder: (context, url) => CircularProgressIndicator(
                  color: Theme.of(context).hintColor,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            // Positioned(
            //   top: appBarHeight / 2 ,
            //   left: appBarHeight / 2,
            //   child: CachedNetworkImage(
            //     imageUrl: user.imageUrl,
            //     imageBuilder: (context, imageProvider) => CircleAvatar(
            //       radius: circleAvatarRadius,
            //       backgroundImage: NetworkImage(user.imageUrl),
            //     ),
            //     placeholder: (context, url) => CircularProgressIndicator(
            //       color: Theme.of(context).hintColor,
            //     ),
            //   ),
            // ),
            // Positioned(
              // top: appBarHeight / 1.5 + circleAvatarRadius / 2,
              // left: appBarHeight / 2 + circleAvatarRadius * 2,
              // right: 16,
              // child: Expanded(
                // child: Center(
                  // child: Text(
                    // user.name,
                    // style: const TextStyle(
                      // fontSize: 22,
                      // fontWeight: FontWeight.bold,
                    // ),
                  // ),
                // ),
              // ),
            // ),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Expanded(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.bio.value != ''
                      ? Text(
                          user.bio.value,
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        )
                      : buttonAlterProfile(true),
                  const SizedBox(height: 10),
                  user.location.value != ''
                      ? Row(
                          children: [
                            Text(
                              user.location.value,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(
                              Icons.location_on,
                              color: Colors.red,
                            )
                          ],
                        )
                      : buttonAlterProfile(false)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonAlterProfile(bool isBio) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: showBioDialog,
        child: Container(
          width: 118,
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(12)),
          child: isBio
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Adicionar bio',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.edit_note_outlined)
                  ],
                )
              : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Localização',
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.location_on, color: Colors.red)
                  ],
                ),
        ),
      ),
    );
  }

  void showBioDialog() {
    TextEditingController controller = TextEditingController();
    int maxCharacter = 100;
    final currentCharLength = Rx<int>(0);

    Get.dialog(
      Dialog(
        child: SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.black),
                      controller: controller,
                      maxLines: null,
                      maxLength: maxCharacter,
                      onChanged: (value) {
                        currentCharLength.value = value.length;
                      },
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Digite sua bio aqui...',
                        hintStyle: const TextStyle(color: Colors.grey),
                        counterText: '${currentCharLength.value}/$maxCharacter',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          "Fechar",
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: TextButton(
                          onPressed: () {
                            mineController.editBio(controller.text);
                            user.bio.value = controller.text;
                            Get.back();
                          },
                          child: const Text(
                            "Salvar",
                            style: TextStyle(
                                color: Color.fromARGB(255, 83, 172, 60),
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


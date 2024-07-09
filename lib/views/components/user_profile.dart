import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerrado_vivo/controllers/mine_controller.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/utils/cities_list.dart';
import 'package:cerrado_vivo/views/components/listview_cities.dart';
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
    final double circleAvatarRadius = appBarHeight;

    print(systemBarHeight.toString());

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.33,
      child: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            title: Text(user.name), //isCurrentUser ? const Text('Seu Perfil') : const Text('Coletor'),
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
          Container(
            height: MediaQuery.of(context).size.height * 0.23,
            padding: const EdgeInsets.only(top: 16.0,left: 16.0, right: 16.0),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CachedNetworkImage(
                        imageUrl: user.imageUrl,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: circleAvatarRadius,
                          backgroundImage: NetworkImage(user.imageUrl),
                        ),
                        placeholder: (context, url) => CircularProgressIndicator(
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const SizedBox(width: 16,),
                      Flexible(
                        child: Obx(() {
                          return user.bio.value != ''
                            ? Text(
                                user.bio.value,
                                maxLines: 5,
                                textAlign: TextAlign.justify,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              )
                            : buttonAlterProfile(true);
                        }),
                      )
                    ],
                  ),
                  Obx(() {
                    return user.location.value != ''
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
                      : buttonAlterProfile(false);
                    }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buttonAlterProfile(bool isBio) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: isBio ? showBioDialog : showLocationDialog,
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
                      TextButton(
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

  void showLocationDialog() {
    try {
      String? selectedCity;

      Get.dialog(
        AlertDialog(
          title: const Text('Selecione sua cidade'),
          scrollable: true,
          content: SizedBox(
            width: 250,
            height: 400,
            child: ListviewCities(
              userApp: user,
              onCitySelected: (city) {
                selectedCity = city;
              },
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                TextButton(
                  onPressed: () {
                    if (selectedCity != null) {
                      mineController.editLocation(selectedCity);
                      user.location.value = selectedCity!;
                      Get.back();
                    }
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Color.fromARGB(255, 83, 172, 60),
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  } 
}

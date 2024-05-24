import 'package:cached_network_image/cached_network_image.dart';
import 'package:cerrado_vivo/models/chat_user.dart';
import 'package:cerrado_vivo/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatelessWidget {
  final ChatUser user;

  const UserDrawer({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: 33),
              CachedNetworkImage(
                imageUrl: user.imageUrl,
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  radius: 85,
                  backgroundImage: imageProvider,
                ),
                width: 170, 
                height: 170,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error)
              ),
              const SizedBox(height: 19),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user.origins,
                          style: const TextStyle(fontSize: 13),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey,
            margin: const EdgeInsets.only(top: 8),
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: const ListTile(
                  title: Text("Alterar dados"),
                  leading: Icon(Icons.person_outline_sharp),
                ),
              ),
              GestureDetector(
                onTap: () {
                  AuthService().logout();
                  Navigator.of(context)
                    .pushNamedAndRemoveUntil('/LoginPage', (route) => false);
                },
                child: const ListTile(
                  title: Text("Sair"),
                  leading: Icon(Icons.exit_to_app_rounded),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}



import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/auth/auth_service.dart';
import 'package:cerrado_vivo/pages/login_page.dart';
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
              CircleAvatar(
                radius: 85,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              const SizedBox(height: 19),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
              ListTile(
                title: const Text('Alterar dados'),
                leading: GestureDetector(
                  onTap: () {},
                  child: const Icon(Icons.person_outline_sharp),
                ),
              ),
              ListTile(
                title: const Text('Sair'),
                leading: GestureDetector(
                  onTap: () {
                    AuthService().logout();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                  child: const Icon(Icons.exit_to_app_rounded),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

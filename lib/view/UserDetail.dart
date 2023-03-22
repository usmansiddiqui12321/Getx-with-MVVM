import 'package:flutter/material.dart';
import 'package:getxwithmvvm/res/Colors/AppColors.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  }) : super(key: key);

  final String? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Hero(
            tag: "userImageTag",
            child: CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(avatar.toString()),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '$firstName $lastName',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            email.toString(),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          const Divider(
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border:
                      Border.all(color: AppColors.primaryColor, width: 1.8)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('ID'),
                    subtitle: Text(id.toString()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Name'),
                    subtitle: Text(email.toString()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: const Text('Email'),
                    subtitle: Text(email.toString()),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

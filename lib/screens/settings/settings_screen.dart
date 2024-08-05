import 'package:emeal/services/firebase_auth_methods.dart';
import 'package:emeal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().changePassword(context);
            },
            text: 'Reset Passowrd',
          ),
          const SizedBox(height: 10),
          if (!user.emailVerified && !user.isAnonymous)
            CustomButton(
              onTap: () {
                context
                    .read<FirebaseAuthMethods>()
                    .sendEmailVerification(context);
              },
              text: 'Verify Email',
            ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().signOut(context);
            },
            text: 'Sign Out',
          ),
        ],
      ),
    );
  }
}

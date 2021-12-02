import 'package:flutter/material.dart';
import '../forms/account_password_form.dart';

class AccountPassword extends StatelessWidget {
  const AccountPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage("assets/images/secure.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const AccountPasswordForm(),
          ],
        ),
      ),
    );
  }
}

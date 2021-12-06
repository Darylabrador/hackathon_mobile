import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/account_provider.dart';
import '../../../models/account.dart';

import '../forms/account_information_form.dart';
import '../../../services/error_service.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: Provider.of<AccountProvider>(context).getInfoAccount(),
        builder: (ct, AsyncSnapshot<Map<String, dynamic>> accountSnapshot) {
          if (accountSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!accountSnapshot.hasData) {
            return ErrorService.showError("Service indisponible");
          }

          Account accountData = Account(
            id: accountSnapshot.data!["id"],
            email: accountSnapshot.data!["email"],
            surname: accountSnapshot.data!["surname"],
            firstname: accountSnapshot.data!["firstname"],
            gender: accountSnapshot.data!["gender"],
            yearOld: accountSnapshot.data!["age"],
          );

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/default.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                AccountInformationForm(accountData: accountData),
              ],
            ),
          );
        },
      ),
    );
  }
}

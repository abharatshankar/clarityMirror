import 'package:clarity_mirror/utils/app_colors.dart';
import 'package:clarity_mirror/utils/app_fonts.dart';
import 'package:flutter/material.dart';

import '../appbar_with_more_button.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstColors.themeBackgroundColor,
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                    children: [
            const AppBarWithMoreButton(
              titleTxt: 'Account Settings',
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: AppConstColors.appBoldTextColor,
            ),
            titleAndTextfield(title: 'First Name'),
            titleAndTextfield(title: 'Last Name'),
            titleAndTextfield(title: 'Email ID'),
            titleAndTextfield(title: 'Phone Number'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Billing Address',
                      style: AppFonts().sego14normal.copyWith(height: 1),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: TextFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Shipping Address',
                      style: AppFonts().sego14normal.copyWith(height: 1),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: TextFormField(
                    decoration: const InputDecoration(border: InputBorder.none),
                    minLines:
                        6, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                  )),
            ),
            SizedBox(height:20),
                    ],
                  ),
          )),
    );
  }

  Widget titleAndTextfield({required String title}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  title,
                  style: AppFonts().sego14normal.copyWith(height: 1),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.white),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              )),
        ),
      ],
    );
  }
}

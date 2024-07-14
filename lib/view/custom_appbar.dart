import 'package:flutter/material.dart';

import '../utils/app_fonts.dart';
import '../utils/app_strings.dart';
import 'notification_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          AppStrings.backNavIcon,
                          height: 31,
                          width: 39,
                          fit: BoxFit.fill,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      "Profile",
                      style: AppFonts().sego29normal,
                    ),
                    const Spacer(),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const NotificationScreen()));
                        },
                        child: const Icon(
                          Icons.notifications,
                          size: 40,
                          color: Colors.white,
                        ))
                  ],
                );
  }
}
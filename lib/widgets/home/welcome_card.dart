import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';

class WelcomeCard extends StatelessWidget {
  final String username;

  const WelcomeCard({
    Key? key,
    this.username = "Admin",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF214098),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome Back,",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    SvgIcon(
                          assetPath: 'assets/icons/user.svg',
                          color: Colors.white,
                          size: 28,
                        ),
                    SizedBox(width: 8),
                    Text(
                      "$username ",
                      style: TextStyle(
                        color: Color(0xFFFFF100),
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      "!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

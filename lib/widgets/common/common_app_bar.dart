import 'package:flutter/material.dart';
import '../home/notification_popup.dart';
import '../home/user_popup.dart';
import '../../pages/home_page.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.grey[100],
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeGCLPage()),
              (route) => false,
            );
          },
          child: Image.asset('assets/images/gcl_logo.png', height: 40),
        ),
      ),
      actions: [
        NotificationPopup(),
        SizedBox(width: 8),
        UserPopup(),
        SizedBox(width: 12),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

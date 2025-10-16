import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
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
          icon: SvgIcon(
            assetPath: 'assets/icons/drawer.svg',
            color: Colors.black,
            size: 14,
          ),
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
          child: Image.asset('assets/images/logo.webp', height: 40),
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

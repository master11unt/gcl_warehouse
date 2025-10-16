import 'package:flutter/material.dart';
import 'package:gcl_warehouse/pages/login_page.dart';
import 'package:gcl_warehouse/pages/profile_page.dart';
import 'package:gcl_warehouse/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common/svg_icon.dart';

class UserPopup extends StatefulWidget {
  const UserPopup({Key? key}) : super(key: key);

  @override
  State<UserPopup> createState() => _UserPopupState();
}

class _UserPopupState extends State<UserPopup> {
  OverlayEntry? _overlayEntry;
  final GlobalKey _buttonKey = GlobalKey();
  bool _isPopupOpen = false;

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: () => _showUserPopup(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: _isPopupOpen
            ? BoxDecoration(
                color: const Color(0xFF0F172A),
                shape: BoxShape.circle,
              )
            : null,
        child: SvgIcon(
          assetPath: 'assets/icons/user_outline.svg',
          color: _isPopupOpen ? Colors.white : Colors.black,
          size: 24,
        ),
      ),
    );
  }

  void _showUserPopup(BuildContext context) {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {
        _isPopupOpen = false;
      });
      return;
    }

    setState(() {
      _isPopupOpen = true;
    });

    final RenderBox? renderBox =
        _buttonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _hidePopup,
        behavior: HitTestBehavior.translucent,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Positioned(
                top: buttonPosition.dy + buttonSize.height + 5,
                right: MediaQuery.of(context).size.width -
                    buttonPosition.dx -
                    buttonSize.width,
                child: GestureDetector(
                  onTap: () {},
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUserMenuItem(
                            iconPath: 'assets/icons/user_outline.svg',
                            text: "Your Profile",
                            onTap: () {
                              _hidePopup();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePage(),
                                ),
                              );
                            },
                          ),
                          _buildUserMenuItem(
                            iconPath: 'assets/icons/setting.svg',
                            text: "Settings",
                            onTap: () {
                              _hidePopup();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsPage(),
                                ),
                              );
                            },
                          ),
                          _buildUserMenuItem(
                            iconPath: 'assets/icons/logout.svg',
                            text: "Sign out",
                            onTap: () async {
                              _hidePopup();

                              // Confirmation dialog
                              final shouldLogout = await showDialog<bool>(
                                context: context,
                                barrierDismissible: true,
                                builder: (ctx) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.12),
                                          blurRadius: 18,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 56,
                                          height: 56,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF214098), // app primary color
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        const Text(
                                          'Sign out',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'Are you sure you want to sign out from the app?',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14, color: Color(0xFF4B5563)),
                                        ),
                                        const SizedBox(height: 18),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                                  side: const BorderSide(color: Color(0xFF9CA3AF)),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                ),
                                                onPressed: () => Navigator.of(ctx).pop(false),
                                                child: const Text('No', style: TextStyle(color: Color(0xFF374151))),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(0xFF214098), // app primary color
                                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                ),
                                                onPressed: () => Navigator.of(ctx).pop(true),
                                                child: const Text('Yes', style: TextStyle(color: Colors.white)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );

                              if (shouldLogout == true) {
                                await _performLogout();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hidePopup() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    setState(() {
      _isPopupOpen = false;
    });
  }

  Future<void> _performLogout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('rememberMe');
      await prefs.remove('username');
    } catch (_) {}
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  Widget _buildUserMenuItem({
    required String iconPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SvgIcon(
                assetPath: iconPath,
                size: 18,
                color: const Color(0xFF6B7280),
              ),
              const SizedBox(width: 12),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../common/svg_icon.dart';

class NotificationPopup extends StatefulWidget {
  const NotificationPopup({Key? key}) : super(key: key);

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  String selectedNotificationTab = "All";
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
      onTap: () => _showNotificationPopup(context),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: _isPopupOpen
            ? BoxDecoration(
                color: const Color(0xFF0F172A),
                shape: BoxShape.circle,
              )
            : null,
        child: SvgIcon(
          assetPath: 'assets/icons/bell_outline.svg',
          color: _isPopupOpen ? Colors.white : Colors.black,
          size: 22,
        ),
      ),
    );
  }

  void _showNotificationPopup(BuildContext context) {
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
                    child: StatefulBuilder(
                      builder: (context, setPopupState) {
                        return Container(
                          width: 280,
                          constraints: const BoxConstraints(maxHeight: 180),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
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
                              Container(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildNotificationTab(
                                      "All",
                                      "assets/icons/bell_outline.svg",
                                      selectedNotificationTab == "All",
                                      () {
                                        setPopupState(() {
                                          selectedNotificationTab = "All";
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    _buildNotificationTab(
                                      "Info",
                                      "assets/icons/info_outline.svg",
                                      selectedNotificationTab == "Info",
                                      () {
                                        setPopupState(() {
                                          selectedNotificationTab = "Info";
                                        });
                                      },
                                    ),
                                    const SizedBox(width: 4),
                                    _buildNotificationTab(
                                      "Transaction",
                                      "assets/icons/cargo_out_outline.svg",
                                      selectedNotificationTab == "Transaction",
                                      () {
                                        setPopupState(() {
                                          selectedNotificationTab =
                                              "Transaction";
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 1,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                color: const Color(0xFFE5E7EB),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: const Center(
                                    child: Text(
                                      "No notifications found.",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF9CA3AF),
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xFFE5E7EB),
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _hidePopup();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgIcon(
                                                assetPath:
                                                    'assets/icons/check_circle.svg',
                                                color: Color(0xFF6B7280),
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                "Mark all as read",
                                                style: TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 16,
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          _hidePopup();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgIcon(
                                                assetPath:
                                                    'assets/icons/visibility_outline.svg',
                                                color: Color(0xFF6B7280),
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              const Text(
                                                "See all",
                                                style: TextStyle(
                                                  color: Color(0xFF6B7280),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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

  Widget _buildNotificationTab(
    String label,
    String iconPath,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF0F172A) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              assetPath: iconPath,
              size: 14,
              color: isSelected ? Colors.white : const Color(0xFF6B7280),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF0F172A),
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../pages/home_page.dart';
import '../../pages/ticket_page.dart';
import '../../pages/inventory_page.dart';
import '../../pages/warehouse_layout_page.dart';
import '../../pages/stuffing_page.dart';
import '../../pages/warehouse_report_page.dart';
import '../../pages/user_page.dart';

class CustomDrawer extends StatefulWidget {
  final String? currentPage; // Tambahkan parameter untuk halaman aktif
  
  const CustomDrawer({Key? key, this.currentPage}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? hoveredItem;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Image.asset('assets/images/gcl_logo.png', height: 40),
              ),
            ),
            _drawerMenuItem(Icons.home, "Home", "home", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeGCLPage()),
              );
            }),
            _drawerMenuItem(Icons.confirmation_number, "Ticket", "ticket", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TicketPage()),
              );
            }),
            _drawerMenuItem(Icons.inventory_2, "Inventory", "inventory", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => InventoryPage()),
              );
            }),
            _drawerMenuItem(Icons.layers, "Rack", "rack", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WarehouseLayoutPage()),
              );
            }),
            _drawerMenuItem(Icons.pallet, "Stuffing", "stuffing", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => StuffingPage()),
              );
            }),
            _drawerMenuItem(Icons.menu_book, "Report", "report", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => WarehouseReportPage()),
              );
            }),
            _drawerMenuItem(Icons.people, "User", "user", () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => UserPage()),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _drawerMenuItem(IconData icon, String label, String itemKey, VoidCallback? onTap) {
    bool isHovered = hoveredItem == itemKey;
    bool isActive = widget.currentPage == itemKey;
    bool isClickable = onTap != null;
    
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) {
          if (isClickable) {
            setState(() {
              hoveredItem = itemKey;
            });
          }
        },
        onExit: (_) {
          setState(() {
            hoveredItem = null;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isActive
                ? const Color(0xFF1F2937) 
                : isHovered 
                    ? const Color(0xFF1F2937)
                    : Colors.transparent,
            border: Border.all(
              color: (isActive || isHovered)
                  ? const Color(0xFF1F2937) 
                  : Colors.transparent,
              width: isActive ? 2 : 1, // Thicker border for active state
            ),
            boxShadow: (isHovered || isActive)
                ? [
                    BoxShadow(
                      color: const Color(0xFF1F2937).withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                transform: Matrix4.identity()
                  ..scale((isHovered || isActive) ? 1.1 : 1.0),
                child: Icon(
                  icon,
                  color: (isActive || isHovered)
                      ? Colors.white
                      : (isClickable ? Colors.black87 : Colors.grey[500]),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                style: TextStyle(
                  fontWeight: isActive
                      ? FontWeight.w800
                      : isHovered 
                          ? FontWeight.w700 
                          : FontWeight.w600,
                  fontSize: (isHovered || isActive) ? 16.5 : 16,
                  color: (isActive || isHovered)
                      ? Colors.white
                      : (isClickable ? Colors.black87 : Colors.grey[500]),
                  letterSpacing: (isHovered || isActive) ? 0.3 : 0,
                ),
                child: Text(label),
              ),
              if (isClickable) ...[
                const Spacer(),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  transform: Matrix4.identity()
                    ..translate((isHovered || isActive) ? 4.0 : 0.0, 0.0),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

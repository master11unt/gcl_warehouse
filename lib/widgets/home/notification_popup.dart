import 'package:flutter/material.dart';

class NotificationPopup extends StatefulWidget {
  const NotificationPopup({Key? key}) : super(key: key);

  @override
  State<NotificationPopup> createState() => _NotificationPopupState();
}

class _NotificationPopupState extends State<NotificationPopup> {
  String selectedNotificationTab = "All";

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      offset: Offset(-250, 50),
      elevation: 8,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(8),
        child: Icon(Icons.notifications_none, color: Colors.black, size: 24),
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            enabled: false, 
            child: Container(
              width: 1000,
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width - 40,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Filter Tabs
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: _notificationTab("All", selectedNotificationTab == "All", () {
                            setState(() {
                              selectedNotificationTab = "All";
                            });
                          }),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: _notificationTab("Info", selectedNotificationTab == "Info", () {
                            setState(() {
                              selectedNotificationTab = "Info";
                            });
                          }),
                        ),
                        SizedBox(width: 12), 
                        Expanded(
                          child: _notificationTab("Transaction", selectedNotificationTab == "Transaction", () {
                            setState(() {
                              selectedNotificationTab = "Transaction";
                            });
                          }),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    height: 1,
                    color: Color(0xFFE5E7EB),
                  ),
                  
                  Container(
                    height: 120,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "No notifications found.",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Bottom actions
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    decoration: BoxDecoration(
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
                              Navigator.pop(context);
                              // Mark all as read functionality
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Color(0xFF6B7280),
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    "Mark all as read",
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              // See all functionality
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.visibility_outlined,
                                  color: Color(0xFF6B7280),
                                  size: 18,
                                ),
                                SizedBox(width: 6),
                                Flexible(
                                  child: Text(
                                    "See all",
                                    style: TextStyle(
                                      color: Color(0xFF6B7280),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ];
      },
    );
  }

  Widget _notificationTab(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF374151) : Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected ? Color(0xFF374151) : Color(0xFFD1D5DB),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (label == "All")
                Icon(
                  Icons.notifications_outlined,
                  size: 16,
                  color: isSelected ? Colors.white : Color(0xFF6B7280),
                )
              else if (label == "Info")
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: isSelected ? Colors.white : Color(0xFF6B7280),
                )
              else if (label == "Transaction")
                Icon(
                  Icons.receipt_long_outlined,
                  size: 16,
                  color: isSelected ? Colors.white : Color(0xFF6B7280),
                ),
              SizedBox(width: 1),
              Flexible(
                child: Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Color(0xFF374151),
                    fontSize: 13, // Sedikit dikecilkan untuk mencegah overflow
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

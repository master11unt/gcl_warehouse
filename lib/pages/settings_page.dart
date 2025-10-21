import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedTabIndex = 0;
  int _currentPage = 1;
  final int _totalPages = 3;
  final TextEditingController _searchController = TextEditingController();

  final List<String> _tabs = [
    'Activity',
    'Notification',
    'Language',
    'Appearance',
    'Documentation',
    'Help Center',
    'About Us',
  ];

  final List<Map<String, dynamic>> _activityData = [
    {
      'date': '2025-09-23 16:38:32',
      'action': 'Cargo In',
      'variable': 'GTW-20250922025542',
      'path': '/cargo-in/GTW-20250922025542',
      'status': 'Success',
    },
    {
      'date': '2025-07-08 10:39:40',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2025-05-27 09:45:31',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2025-05-27 09:45:05',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2025-05-27 09:44:49',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2025-05-23 09:40:37',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2025-04-14 15:02:35',
      'action': 'Add User',
      'variable': '-',
      'path': '/admin/user',
      'status': 'Success',
    },
    {
      'date': '2024-03-20 15:40:23',
      'action': 'Update Tallysheet',
      'variable': 'ABC123',
      'path': '/tallysheet/ABC123',
      'status': 'Success',
    },
    {
      'date': '2024-03-20 14:50:12',
      'action': 'Update Tallysheet',
      'variable': 'ABC123',
      'path': '/tallysheet/ABC123',
      'status': 'Success',
    },
    {
      'date': '2024-03-20 14:39:40',
      'action': 'Update Tallysheet',
      'variable': 'ABC123',
      'path': '/tallysheet/ABC123',
      'status': 'Success',
    },
    {
      'date': '2024-03-20 14:38:23',
      'action': 'Update Tallysheet',
      'variable': 'ABC123',
      'path': '/tallysheet/ABC123',
      'status': 'Success',
    },
  ];

  final List<Map<String, String>> _loginHistory = [
    {'type': 'Login', 'date': '2025-09-19 19:07:57'},
    {'type': 'Login', 'date': '2025-09-19 14:53:49'},
    {'type': 'Login', 'date': '2025-09-19 09:30:36'},
    {'type': 'Login', 'date': '2025-09-19 09:24:04'},
    {'type': 'Login', 'date': '2025-09-19 08:31:24'},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToPreviousPage() {
    if (_currentPage > 1) {
      setState(() {
        _currentPage--;
      });
    }
  }

  void _goToNextPage() {
    if (_currentPage < _totalPages) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      setState(() {
        _currentPage = page;
      });
    }
  }

  List<int> _getVisiblePages() {
    List<int> pages = [];
    int total = _totalPages;
    int current = _currentPage;

    if (total <= 3) {
      for (int i = 1; i <= total; i++) {
        pages.add(i);
      }
    } else {
      int start = current - 1;
      int end = current + 1;

      if (start < 1) {
        start = 1;
        end = 3;
      }
      if (end > total) {
        end = total;
        start = total - 2;
      }

      if (start > 1) {
        pages.add(1);
        if (start > 2) {
          pages.add(-1);
        }
      }

      for (int i = start; i <= end; i++) {
        pages.add(i);
      }

      if (end < total) {
        if (end < total - 1) {
          pages.add(-1);
        }
        pages.add(total);
      }
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with back button and title
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF374151)),
                    onPressed: () {
                      Navigator.of(context).maybePop();
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF374151),
                    ),
                  ),
                ],
              ),
            ),
            // Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF374151)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Color(0xFF6B7280),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
            ),
            // Tab bar (fixed)
            Container(
              color: Colors.grey[100],
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _tabs.length,
                itemBuilder: (context, index) {
                  bool isSelected = _selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: isSelected ? const Color(0xFF214098) : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? const Color(0xFF214098) : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Expanded scrollable content
            Expanded(
              child: _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildActivityTab();
      case 1:
        return _buildNotificationTab();
      case 2:
        return _buildLanguageTab();
      case 3:
        return _buildAppearanceTab();
      case 4:
        return _buildDocumentationTab();
      case 5:
        return _buildHelpCenterTab();
      case 6:
        return _buildAboutUsTab();
      default:
        return _buildActivityTab();
    }
  }

  Widget _buildActivityTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'My Activity',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 16),

        // Activity List
        Column(
          children: [
            ..._activityData
                .take(10)
                .map(
                  (activity) => Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: _buildActivityItem(activity),
                  ),
                ),

            const SizedBox(height: 16),

            const SizedBox(height: 8),

            Align(
              alignment: Alignment.center,
              child: Text(
                'Showing ${_activityData.length} Results (Page $_currentPage of $_totalPages)',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Divider
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(color: Colors.grey[300], thickness: 1, height: 1),
            ),

            // Pagination
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSimpleNavButton(
                    label: 'Prev',
                    enabled: _currentPage > 1,
                    isPrev: true,
                    onTap: _goToPreviousPage,
                  ),

                  const SizedBox(width: 4),

                  ..._getVisiblePages().map((page) {
                    if (page == -1) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          '...',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: _buildSimplePageButton(
                        page: page,
                        active: _currentPage == page,
                        onTap: () => _goToPage(page),
                      ),
                    );
                  }),

                  const SizedBox(width: 4),

                  _buildSimpleNavButton(
                    label: 'Next',
                    enabled: _currentPage < _totalPages,
                    isPrev: false,
                    onTap: _goToNextPage,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        const Text(
          'Last Login History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 16),

        Column(
          children:
              _loginHistory
                  .map(
                    (login) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: _buildLoginHistoryItem(login),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildActivityItem(Map<String, dynamic> activity) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['date'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  activity['action'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Variable: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: activity['variable'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Path: ',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                      TextSpan(
                        text: activity['path'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFDCFCE7), 
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              activity['status'],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF16A34A),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginHistoryItem(Map<String, String> login) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            login['type']!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF374151),
            ),
          ),
          Text(
            login['date']!,
            style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildSimpleNavButton({
    required String label,
    required bool enabled,
    required bool isPrev,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPrev) ...[
            Icon(
              Icons.chevron_left,
              size: 14,
              color:
                  enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
            ),
            const SizedBox(width: 2),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color:
                  enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (!isPrev) ...[
            const SizedBox(width: 2),
            Icon(
              Icons.chevron_right,
              size: 14,
              color:
                  enabled ? const Color(0xFF3B82F6) : const Color(0xFFD1D5DB),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSimplePageButton({
    required int page,
    required bool active,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: active ? const Color(0xFF3B82F6) : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Center(
          child: Text(
            '$page',
            style: TextStyle(
              fontSize: 12,
              color: active ? const Color(0xFF3B82F6) : const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Sample notification data
  final List<Map<String, dynamic>> _notificationData = [
    {
      'title': 'New Ticket Assignment',
      'message': 'You have been assigned to ticket #TK-2024-001',
      'time': '2 minutes ago',
      'type': 'assignment',
      'isRead': false,
    },
    {
      'title': 'System Maintenance',
      'message': 'Scheduled maintenance will begin at 02:00 AM tonight',
      'time': '1 hour ago',
      'type': 'system',
      'isRead': false,
    },
    {
      'title': 'Inventory Update',
      'message': 'Container ABC-123 has been successfully moved to Yard A',
      'time': '3 hours ago',
      'type': 'inventory',
      'isRead': true,
    },
    {
      'title': 'Task Completed',
      'message': 'Stuffing process for shipment SHP-2024-045 completed',
      'time': '5 hours ago',
      'type': 'task',
      'isRead': true,
    },
    {
      'title': 'New Message',
      'message': 'You have received a new message from Admin',
      'time': '1 day ago',
      'type': 'message',
      'isRead': true,
    },
    {
      'title': 'Security Alert',
      'message': 'Unusual login detected from new device',
      'time': '2 days ago',
      'type': 'security',
      'isRead': false,
    },
  ];

  Widget _buildNotificationTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Notifications',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF374151),
              ),
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                  },
                  child: const Text(
                    'Mark all as read',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3B82F6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                  },
                  icon: const Icon(
                    Icons.clear_all,
                    size: 20,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Notification List
        Column(
          children:
              _notificationData
                  .map(
                    (notification) => Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: _buildNotificationItem(notification),
                    ),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border:
            notification['isRead']
                ? null
                : Border.all(
                  color: Color(0xFF3B82F6).withOpacity(0.2),
                  width: 1,
                ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _getNotificationIconColor(notification['type']),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              _getNotificationIcon(notification['type']),
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                              notification['isRead']
                                  ? FontWeight.w500
                                  : FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),
                    ),
                    if (!notification['isRead'])
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF3B82F6),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  notification['message'],
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notification['time'],
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF9CA3AF),
              size: 16,
            ),
            onSelected: (value) {
            },
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'mark_read',
                    child: Row(
                      children: [
                        Icon(Icons.mark_email_read, size: 16),
                        SizedBox(width: 8),
                        Text('Mark as read'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 16),
                        SizedBox(width: 8),
                        Text('Delete'),
                      ],
                    ),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  Color _getNotificationIconColor(String type) {
    switch (type) {
      case 'assignment':
        return const Color(0xFF10B981);
      case 'system':
        return const Color(0xFFF59E0B);
      case 'inventory':
        return const Color(0xFF3B82F6);
      case 'task':
        return const Color(0xFF8B5CF6);
      case 'message':
        return const Color(0xFF06B6D4);
      case 'security':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'assignment':
        return Icons.assignment;
      case 'system':
        return Icons.settings;
      case 'inventory':
        return Icons.inventory;
      case 'task':
        return Icons.task_alt;
      case 'message':
        return Icons.message;
      case 'security':
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }

  Widget _buildLanguageTab() {
    return const Center(
      child: Text(
        'Language Settings\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildAppearanceTab() {
    return const Center(
      child: Text(
        'Appearance Settings\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildDocumentationTab() {
    return const Center(
      child: Text(
        'Documentation\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildHelpCenterTab() {
    return const Center(
      child: Text(
        'Help Center\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      ),
    );
  }

  Widget _buildAboutUsTab() {
    return const Center(
      child: Text(
        'About Us\nComing Soon',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Color(0xFF6B7280)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "user"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistics Cards
              _buildStatisticsSection(),
              const SizedBox(height: 24),
              
              // User Management Section
              _buildUserManagementSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Column(
      children: [
        // First row with 3 cards
        Row(
          children: [
            Expanded(child: _buildStatCard('Total User', '13', const Color(0xFF2346A0))),
            const SizedBox(width: 8),
            Expanded(child: _buildStatCard('Total Roles', '4', const Color(0xFF2346A0))),
            const SizedBox(width: 8),
            Expanded(child: _buildStatCard('Region', '2', const Color(0xFF2346A0))),
          ],
        ),
        const SizedBox(height: 8),
        // Second row with 2 cards
        Row(
          children: [
            Expanded(flex: 1, child: _buildStatCard('Total Team', '0', const Color(0xFF2346A0))),
            const SizedBox(width: 8),
            Expanded(flex: 1, child: _buildStatCard('Permission', '11', const Color(0xFF2346A0))),
            Expanded(flex: 1, child: const SizedBox()), // Empty space for balance
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildUserManagementSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and add button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'User Management',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.search,
                  color: Color(0xFF9CA3AF),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search by username or name...',
                      hintStyle: TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          
          // User table
          _buildUserTable(),
        ],
      ),
    );
  }

  Widget _buildUserTable() {
    final users = [
      {'username': 'admin', 'fullName': 'admin', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'User', 'fullName': 'user', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'ppjk', 'fullName': 'ppjk', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'beacukai', 'fullName': 'Bea Cukai', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'benjo', 'fullName': 'Benjo', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'iwan', 'fullName': 'Iwan', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'bimo', 'fullName': 'Bimo', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'umi', 'fullName': 'Nafisah Sari', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'nugi', 'fullName': 'Nugroho', 'region': 'JAKARTA', 'status': 'active'},
      {'username': 'doni', 'fullName': 'Doni', 'region': 'JAKARTA', 'status': 'active'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 6,
            ),
          ],
        ),
        child: DataTable(
          columnSpacing: 20,
          horizontalMargin: 20,
          headingRowHeight: 56,
          dataRowHeight: 56,
          headingRowColor: MaterialStateProperty.all(const Color(0xFFF9FAFB)),
          columns: const [
            DataColumn(
              label: SizedBox(
                width: 100,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 120,
                child: Text(
                  'Full Name',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 100,
                child: Text(
                  'Region',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 100,
                child: Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            DataColumn(
              label: SizedBox(
                width: 80,
                child: Text(
                  'Actions',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          rows: users.map((user) => DataRow(
            cells: [
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    user['username']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 120,
                  child: Text(
                    user['fullName']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Text(
                    user['region']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 100,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF10B981),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                SizedBox(
                  width: 80,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        _showEditUserDialog(user['username']!, user['fullName']!);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        child: const Icon(
                          Icons.lock_open_rounded,
                          size: 16,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )).toList(),
        ),
      ),
    );
  }

  void _showEditUserDialog(String username, String fullName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User: $username'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: username,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: fullName,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle save action
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User $username updated successfully')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

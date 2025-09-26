import 'package:flutter/material.dart';
import '../widgets/common/common_app_bar.dart';
import '../widgets/home/custom_drawer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CommonAppBar(),
      drawer: CustomDrawer(currentPage: "profile"),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Main Profile Card
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 50),
                  padding: const EdgeInsets.fromLTRB(24, 70, 24, 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2937),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                  
                  // Name
                  const Text(
                    'Admin',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Username
                  const Text(
                    '@admin',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFB0BEC5),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Info Grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'NIP',
                          'Please contact HR or support',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoItem(
                          'Division',
                          'warehouse',
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoItem(
                          'Region',
                          'JAKARTA',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildInfoItem(
                          'Group',
                          'No Group',
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Permission
                  Column(
                    children: [
                      const Text(
                        'Permission',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFB0BEC5),
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4B5563),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'jakarta.warehouse.admin.account.all',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionIcon(Icons.bar_chart, () {}),
                      _buildActionIcon(Icons.edit, () {}),
                      _buildActionIcon(Icons.calendar_today, () {}),
                      _buildActionIcon(Icons.school, () {}),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Company Name
                  const Text(
                    'Gateway Container Line ™',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFB0BEC5),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                    ],
                  ),
                ),
                
                // Floating Profile Avatar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color(0xFF374151),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_outline_outlined,
                        size: 50,
                        color: Color(0xFF374151),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // My Performance Section
            Container(
              width: double.infinity,
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
                  Row(
                    children: [
                      const Icon(
                        Icons.bar_chart,
                        color: Color(0xFF374151),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'My Performance',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Comming soon! This feature is under development and will be available in the future.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ), // closing SafeArea
    ));
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFB0BEC5),
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  Widget _buildActionIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: const Color(0xFF4B5563),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
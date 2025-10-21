import 'package:flutter/material.dart';
import 'package:gcl_warehouse/widgets/common/svg_icon.dart';
// import '../widgets/common/common_app_bar.dart';
// import '../widgets/common/custom_drawer.dart';
import '../models/profile_data.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> profile = ProfileData.getDummyProfile();
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: Navigator.of(context).canPop()
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                    color: Color(0xFF374151),
                  ),
                  onPressed: () => Navigator.of(context).maybePop(),
                )
                : null,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF374151),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
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
                      color: const Color(0xFF0F172A),
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
                        Text(
                          profile['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          profile['username'] ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFFB0BEC5),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoItem(
                                'NIP',
                                profile['nip'] ?? '',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildInfoItem(
                                'Division',
                                profile['division'] ?? '',
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
                                profile['region'] ?? '',
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: _buildInfoItem(
                                'Group',
                                profile['group'] ?? '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
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
                                color: Color(0xFF4B5563),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                profile['permission'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildActionIcon(
                              'assets/icons/chart_outline.svg',
                              () {},
                            ),
                            _buildActionIcon('assets/icons/edit.svg', () {}),
                            _buildActionIcon(
                              'assets/icons/personal_detail.svg',
                              () {},
                            ),
                            _buildActionIcon(
                              'assets/icons/achievement.svg',
                              () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          profile['company'] ?? '',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFB0BEC5),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 120,
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
                        child: const Center(
                          child: SvgIcon(
                            assetPath: 'assets/icons/user_outline.svg',
                            color: Color(0xFF374151),
                            size: 70,
                          ),
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
                        const SvgIcon(
                          assetPath: 'assets/icons/chart.svg',
                          color: Color(0xFF0F172A),
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
        ),
      ),
    );
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

  Widget _buildActionIcon(String svgPath, VoidCallback onTap) {
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
        child: Center(
          child: SvgIcon(assetPath: svgPath, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}

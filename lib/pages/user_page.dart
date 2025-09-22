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
              GestureDetector(
                onTap: () {
                  _showAddUserDialog();
                },
                child: Container(
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
      {
        'username': 'admin', 
        'fullName': 'admin', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '',
        'email': '',
        'division': 'Warehouse',
        'role': 'Admin',
        'group': '',
        'permissions': 'jakarta.warehouse.admin.account.all'
      },
      {
        'username': 'User', 
        'fullName': 'user', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '12345678',
        'email': 'user@gcl.com',
        'division': 'Operations',
        'role': 'User',
        'group': 'Staff',
        'permissions': 'jakarta.warehouse.user.basic'
      },
      {
        'username': 'ppjk', 
        'fullName': 'ppjk', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '87654321',
        'email': 'ppjk@gcl.com',
        'division': 'PPJK',
        'role': 'PPJK Officer',
        'group': 'External',
        'permissions': 'jakarta.warehouse.ppjk.documents'
      },
      {
        'username': 'beacukai', 
        'fullName': 'Bea Cukai', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '11223344',
        'email': 'beacukai@kemenkeu.go.id',
        'division': 'Customs',
        'role': 'Customs Officer',
        'group': 'Government',
        'permissions': 'jakarta.warehouse.customs.inspection'
      },
      {
        'username': 'benjo', 
        'fullName': 'Benjo', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '55667788',
        'email': 'benjo@gcl.com',
        'division': 'Warehouse',
        'role': 'Supervisor',
        'group': 'Management',
        'permissions': 'jakarta.warehouse.supervisor.operations'
      },
      {
        'username': 'iwan', 
        'fullName': 'Iwan', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '99887766',
        'email': 'iwan@gcl.com',
        'division': 'Warehouse',
        'role': 'Operator',
        'group': 'Staff',
        'permissions': 'jakarta.warehouse.operator.basic'
      },
      {
        'username': 'bimo', 
        'fullName': 'Bimo', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '44556677',
        'email': 'bimo@gcl.com',
        'division': 'Warehouse',
        'role': 'Operator',
        'group': 'Staff',
        'permissions': 'jakarta.warehouse.operator.basic'
      },
      {
        'username': 'umi', 
        'fullName': 'Nafisah Sari', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '33445566',
        'email': 'umi@gcl.com',
        'division': 'Administration',
        'role': 'Admin Staff',
        'group': 'Staff',
        'permissions': 'jakarta.warehouse.admin.documents'
      },
      {
        'username': 'nugi', 
        'fullName': 'Nugroho', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '22334455',
        'email': 'nugi@gcl.com',
        'division': 'IT',
        'role': 'IT Support',
        'group': 'Technical',
        'permissions': 'jakarta.warehouse.it.system'
      },
      {
        'username': 'doni', 
        'fullName': 'Doni', 
        'region': 'JAKARTA', 
        'status': 'active',
        'nip': '11223366',
        'email': 'doni@gcl.com',
        'division': 'Security',
        'role': 'Security Officer',
        'group': 'Security',
        'permissions': 'jakarta.warehouse.security.access'
      },
    ];

    return Container(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFFE9ECEF),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: DataTable(
              columnSpacing: 40, 
              horizontalMargin: 24,
              headingRowHeight: 50,
              dataRowMinHeight: 40,
              dataRowMaxHeight: 60,
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF3F4F6)),
              dividerThickness: 0,
          columns: const [
            DataColumn(
              label: Text(
                'Username',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Full Name',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Region',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF495057),
                ),
              ),
            ),
          ],
          rows: users.map((user) => DataRow(
            cells: [
              DataCell(
                GestureDetector(
                  onTap: () {
                    _showUserDetailDialog(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      user['username']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF212529),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                GestureDetector(
                  onTap: () {
                    _showUserDetailDialog(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      user['fullName']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF212529),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                GestureDetector(
                  onTap: () {
                    _showUserDetailDialog(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      user['region']!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF212529),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                GestureDetector(
                  onTap: () {
                    _showUserDetailDialog(user);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD1FAE5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: GestureDetector(
                    onTap: () {
                      _showUserDetailDialog(user);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.lock_open,
                        size: 20,
                        color: Color(0xFF6C757D),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void _showUserDetailDialog(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: 600,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and close button
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 20, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: const Text(
                            'User',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1F2937),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, size: 24),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),

                // Scrollable content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: Column(
                      children: [
                        // Avatar and name section
                        Row(
                          children: [
                            // Avatar
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: const Color(0xFF9CA3AF),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  user['username']![0].toLowerCase(),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Name and username
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user['fullName']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                  Text(
                                    '@${user['username']!}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6B7280),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Action buttons
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE5E7EB)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: Color(0xFF6B7280),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: const Color(0xFFE5E7EB)),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.delete_outline,
                                    size: 20,
                                    color: Color(0xFFEF4444),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        
                        // Divider line
                        Container(
                          height: 1,
                          color: const Color(0xFFE5E7EB),
                        ),
                        
                        const SizedBox(height: 24),

                        // User information fields
                        _buildInfoField('Username:', user['username']!),
                        _buildInfoField('Full Name:', user['fullName']!),
                        _buildInfoField('NIP:', user['nip']!),
                        _buildInfoField('Email:', user['email']!),
                        _buildInfoField('Region:', user['region']!),
                        _buildInfoField('Division:', user['division']!),
                        _buildInfoField('Role:', user['role']!),
                        _buildInfoField('Group:', user['group']!),

                        // Status section
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Status:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF374151),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF10B981),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 44,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF10B981),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 2),
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Permissions section
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Permissions',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF374151),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F4F6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                user['permissions']!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF374151),
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '-' : value,
              style: TextStyle(
                fontSize: 14,
                color: value.isEmpty ? const Color(0xFF9CA3AF) : const Color(0xFF1F2937),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddUserDialog() {
    final _formKey = GlobalKey<FormState>();
    final _fullNameController = TextEditingController();
    final _usernameController = TextEditingController();
    final _nipController = TextEditingController();
    final _passwordController = TextEditingController();
    final _emailController = TextEditingController();
    final _divisionController = TextEditingController();
    
    String _selectedRegion = '';
    String _selectedRole = '';
    String _selectedGroup = '';
    String _selectedPermissions = '';
    bool _obscurePassword = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: 1000,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: Row(
                        children: [
                          const SizedBox(width: 24), // Space for balance with close button
                          Expanded(
                            child: Text(
                              'Add New User',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F2937),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close, size: 24),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),

                    // Scrollable form content
                    Flexible(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                        child: Form(
                          key: _formKey,
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFFE5E7EB)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'New User Information',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1F2937),
                                  ),
                                ),
                                const SizedBox(height: 24),

                                // Full Name
                                _buildFormField(
                                  label: 'Full Name',
                                  controller: _fullNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter full name';
                                    }
                                    return null;
                                  },
                                ),

                                // Username
                                _buildFormField(
                                  label: 'Username',
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter username';
                                    }
                                    return null;
                                  },
                                ),

                                // NIP
                                _buildFormField(
                                  label: 'NIP',
                                  controller: _nipController,
                                ),

                                // Password
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Password',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF374151),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: _obscurePassword,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                            color: const Color(0xFF6B7280),
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _obscurePassword = !_obscurePassword;
                                            });
                                          },
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter password';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),

                                // Email
                                _buildFormField(
                                  label: 'Email',
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    if (!value.contains('@')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),

                                // Region Dropdown
                                _buildDropdownField(
                                  label: 'Region',
                                  value: _selectedRegion,
                                  hint: 'Select Region',
                                  items: ['JAKARTA', 'SURABAYA', 'MEDAN', 'MAKASSAR'],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRegion = value ?? '';
                                    });
                                  },
                                ),

                                // Division
                                _buildFormField(
                                  label: 'Division',
                                  controller: _divisionController,
                                ),

                                // Role Dropdown
                                _buildDropdownField(
                                  label: 'Role',
                                  value: _selectedRole,
                                  hint: 'Select Role',
                                  items: ['Admin', 'User', 'Supervisor', 'Operator', 'PPJK Officer', 'Customs Officer'],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedRole = value ?? '';
                                    });
                                  },
                                ),

                                // Group
                                _buildDropdownField(
                                  label: 'Group',
                                  value: _selectedGroup,
                                  hint: 'Select Group',
                                  items: ['Staff', 'Management', 'External', 'Government', 'Technical', 'Security'],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedGroup = value ?? '';
                                    });
                                  },
                                ),

                                // Permissions
                                _buildDropdownField(
                                  label: 'Permissions',
                                  value: _selectedPermissions,
                                  hint: 'Select Permissions',
                                  items: ['Read Only', 'Read & Write', 'Full Access', 'Admin', 'Limited Access', 'Custom'],
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedPermissions = value ?? '';
                                    });
                                  },
                                ),

                                const SizedBox(height: 24),

                                // Create User Button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Handle create user logic here
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('User ${_usernameController.text} created successfully'),
                                            backgroundColor: const Color(0xFF10B981),
                                          ),
                                        );
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFFFF100),
                                      foregroundColor: Color(0xFF1F2937),
                                      padding: const EdgeInsets.symmetric(vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text(
                                      'Create User',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
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
            );
          },
        );
      },
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
          ),
          validator: validator,
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required String hint,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF374151),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value.isEmpty ? null : value,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
          hint: Text(
            hint,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

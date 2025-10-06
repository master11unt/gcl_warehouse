class UserData {
  static List<Map<String, String>> getDummyUsers() {
    return [
      {
        'username': 'admin', 'fullName': 'admin', 'region': 'JAKARTA', 'status': 'active', 'nip': '', 'email': '', 'division': 'Warehouse', 'role': 'Admin', 'group': '', 'permissions': 'jakarta.warehouse.admin.account.all'
      },
      {
        'username': 'User', 'fullName': 'user', 'region': 'JAKARTA', 'status': 'active', 'nip': '12345678', 'email': 'user@gcl.com', 'division': 'Operations', 'role': 'User', 'group': 'Staff', 'permissions': 'jakarta.warehouse.user.basic'
      },
      {
        'username': 'ppjk', 'fullName': 'ppjk', 'region': 'JAKARTA', 'status': 'active', 'nip': '87654321', 'email': 'ppjk@gcl.com', 'division': 'PPJK', 'role': 'PPJK Officer', 'group': 'External', 'permissions': 'jakarta.warehouse.ppjk.documents'
      },
      {
        'username': 'beacukai', 'fullName': 'Bea Cukai', 'region': 'JAKARTA', 'status': 'active', 'nip': '11223344', 'email': 'beacukai@kemenkeu.go.id', 'division': 'Customs', 'role': 'Customs Officer', 'group': 'Government', 'permissions': 'jakarta.warehouse.customs.inspection'
      },
      {
        'username': 'benjo', 'fullName': 'Benjo', 'region': 'JAKARTA', 'status': 'active', 'nip': '55667788', 'email': 'benjo@gcl.com', 'division': 'Warehouse', 'role': 'Supervisor', 'group': 'Management', 'permissions': 'jakarta.warehouse.supervisor.operations'
      },
      {
        'username': 'iwan', 'fullName': 'Iwan', 'region': 'JAKARTA', 'status': 'active', 'nip': '99887766', 'email': 'iwan@gcl.com', 'division': 'Warehouse', 'role': 'Operator', 'group': 'Staff', 'permissions': 'jakarta.warehouse.operator.basic'
      },
      {
        'username': 'bimo', 'fullName': 'Bimo', 'region': 'JAKARTA', 'status': 'active', 'nip': '44556677', 'email': 'bimo@gcl.com', 'division': 'Warehouse', 'role': 'Operator', 'group': 'Staff', 'permissions': 'jakarta.warehouse.operator.basic'
      },
      {
        'username': 'umi', 'fullName': 'Nafisah Sari', 'region': 'JAKARTA', 'status': 'active', 'nip': '33445566', 'email': 'umi@gcl.com', 'division': 'Administration', 'role': 'Admin Staff', 'group': 'Staff', 'permissions': 'jakarta.warehouse.admin.documents'
      },
      {
        'username': 'nugi', 'fullName': 'Nugroho', 'region': 'JAKARTA', 'status': 'active', 'nip': '22334455', 'email': 'nugi@gcl.com', 'division': 'IT', 'role': 'IT Support', 'group': 'Technical', 'permissions': 'jakarta.warehouse.it.system'
      },
      {
        'username': 'doni', 'fullName': 'Doni', 'region': 'JAKARTA', 'status': 'active', 'nip': '11223366', 'email': 'doni@gcl.com', 'division': 'Security', 'role': 'Security Officer', 'group': 'Security', 'permissions': 'jakarta.warehouse.security.access'
      },
    ];
  }

  static Map<String, String> getDummyStats() {
    return {
      'totalUser': '13',
      'totalRoles': '4',
      'region': '2',
      'totalTeam': '0',
      'permission': '11',
    };
  }
}

enum UserRole {
  owner,
  manager,
  staff,
  viewer,
}

class RoleHelper {
  static bool canAccessFinancial(UserRole role) {
    return role == UserRole.owner || role == UserRole.manager;
  }

  static bool canAccessSettings(UserRole role) {
    return role == UserRole.owner;
  }

  static bool canCreateInvoice(UserRole role) {
    return role == UserRole.owner || role == UserRole.manager || role == UserRole.staff;
  }

  static bool canDeleteData(UserRole role) {
    return role == UserRole.owner;
  }

  static bool canManageBusiness(UserRole role) {
    return role == UserRole.owner;
  }

  static String getRoleName(UserRole role) {
    switch (role) {
      case UserRole.owner:
        return 'Owner';
      case UserRole.manager:
        return 'Manager';
      case UserRole.staff:
        return 'Staff';
      case UserRole.viewer:
        return 'Viewer';
    }
  }
}

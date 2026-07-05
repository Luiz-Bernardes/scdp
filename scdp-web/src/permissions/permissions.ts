import { Role } from "./roles";

export function canAccessAdmin(role?: string) {
  return role === Role.SuperAdmin || role === Role.Admin;
}

export function canManageUsers(role?: string) {
  return canAccessAdmin(role);
}

export function canManageTeams(role?: string) {
  return canAccessAdmin(role);
}

export function canManagePauseTypes(role?: string) {
  return canAccessAdmin(role);
}

export function canViewDashboard(role?: string) {
  return role !== undefined;
}
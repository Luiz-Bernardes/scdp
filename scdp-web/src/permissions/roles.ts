export const Roles = {
  SUPER_ADMIN: "super_admin",
  ADMIN: "admin",
  SUPERVISOR: "supervisor",
  AGENT: "agent"
} as const;

export const RoleOptions = [
  Roles.AGENT,
  Roles.SUPERVISOR,
  Roles.ADMIN,
  Roles.SUPER_ADMIN
] as const;

export type Role = typeof Roles[keyof typeof Roles];
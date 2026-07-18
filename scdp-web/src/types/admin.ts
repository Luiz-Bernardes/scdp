export type UserRole =
  | "super_admin"
  | "admin"
  | "supervisor"
  | "agent";

export type AdminUser = {
  id: number;
  name: string;
  email: string;
  role: UserRole;
  active: boolean;
};
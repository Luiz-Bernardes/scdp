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

export type AdminTeamMembership = {
  id: number;

  email: string;

  user_id: number | null;
  user_name: string | null;

  team_id: number;
  team_name: string;

  team_role: "leader" | "member";

  created_at: string;
  updated_at: string;
};
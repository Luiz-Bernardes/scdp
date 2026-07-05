import { Roles } from "./roles";

export type Permission =
  | "manage_system"
  | "manage_users"
  | "manage_teams"
  | "manage_pause_types"
  | "view_reports"
  | "view_team"
  | "manage_team_queue"
  | "finish_pauses"
  | "use_pause_board";


export const permissions = {
  [Roles.SUPER_ADMIN]: [
    "manage_system",
    "manage_users",
    "manage_teams",
    "manage_pause_types",
    "view_reports"
  ],

  [Roles.ADMIN]: [
    "manage_users",
    "manage_teams",
    "manage_pause_types",
    "view_reports"
  ],

  [Roles.SUPERVISOR]: [
    "view_team",
    "manage_team_queue",
    "finish_pauses"
  ],

  [Roles.AGENT]: [
    "use_pause_board"
  ]
} as const;
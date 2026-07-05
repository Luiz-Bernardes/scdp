export const permissions = {
  super_admin: [
    "manage_system",
    "manage_users",
    "manage_teams",
    "manage_pause_types",
    "view_reports"
  ],

  admin: [
    "manage_users",
    "manage_teams",
    "manage_pause_types",
    "view_reports"
  ],

  supervisor: [
    "view_team",
    "manage_team_queue",
    "finish_pauses"
  ],

  agent: [
    "use_pause_board"
  ]
} as const;
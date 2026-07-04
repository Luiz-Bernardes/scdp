export type Slot = {
  pause_id: number;
  user_name: string;
  selected_duration_minutes: number;
  started_at: string;
  expires_at: string | null;
  remaining_seconds: number | null;
} | null;

export type PauseType = {
  id: number;
  name: string;
  slots: Slot[];
};

export type PauseBoard = {
  team_id: number;
  pause_types: PauseType[];
};
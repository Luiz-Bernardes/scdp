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

  has_time_limit: boolean;
  max_duration_minutes: number | null;
  max_concurrent: number;
  requires_queue: boolean;

  slots: (PauseSlot | null)[];
};

export type PauseBoard = {
  team_id: number;
  pause_types: PauseType[];
};
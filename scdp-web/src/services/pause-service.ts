import { api } from "@/lib/api";

type ReservePauseParams = {
  pauseTypeId: number;
  selectedDurationMinutes?: number;
};

export async function reservePause({
  pauseTypeId,
  selectedDurationMinutes
}: ReservePauseParams) {
  const response = await api.post("/pauses/reserve", {
    pause_type_id: pauseTypeId,
    selected_duration_minutes: selectedDurationMinutes
  });

  return response.data;
}

export async function startPause(
  pauseId: number
) {
  const response = await api.post(
    `/pauses/${pauseId}/start`
  );

  return response.data;
}
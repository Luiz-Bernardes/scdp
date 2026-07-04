import { api } from "@/lib/api";
import { PauseBoard } from "@/types/board";

export async function getPauseBoard(
  teamId: number
): Promise<PauseBoard> {
  const response = await api.get(
    `/teams/${teamId}/pause_board`
  );

  return response.data;
}
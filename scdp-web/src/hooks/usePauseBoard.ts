import { useEffect, useState } from "react";

import { getPauseBoard } from "@/services/board-service";
import { PauseBoard } from "@/types/board";

export function usePauseBoard(teamId?: number) {
  const [board, setBoard] = useState<PauseBoard | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!teamId) {
      setLoading(false);
      return;
    }

    getPauseBoard(teamId)
      .then(setBoard)
      .finally(() => {
        setLoading(false);
      });
  }, [teamId]);

  return {
    board,
    setBoard,
    loading
  };
}
"use client";

import { Board } from "@/components/board/Board";
import { EmptyState } from "@/components/ui/EmptyState";
import { Loading } from "@/components/ui/Loading";
import { useAuthStore } from "@/stores/auth-store";
import { usePauseBoard } from "@/hooks/usePauseBoard";

export default function BoardPage() {

  const user = useAuthStore((state) => state.user);

  const { board, loading } = usePauseBoard(user?.team_ids[0]);

  if (loading) {
    return <Loading />;
  }

  if (!board) {
    return (
      <EmptyState
        title="Board de Pausas"
        description="Nenhum board encontrado."
      />
    );
  }

  return <Board board={board} />;
}
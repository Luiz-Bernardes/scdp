"use client";

import { PauseBoard } from "@/types/board";

import { PauseTypeColumn } from "./PauseTypeColumn";
import { ReservePauseModal } from "./ReservePauseModal";

import { PageTitle } from "@/components/ui/PageTitle";

import { useBoardActions } from "@/hooks/useBoardActions";

type Props = {
  board: PauseBoard;
};

export function Board({
  board
}: Props) {

  const boardActions =
    useBoardActions();

  return (
    <main className="p-8">

      <PageTitle>
        Board de Pausas
      </PageTitle>

      {board.pause_types.map((pauseType) => (
        <PauseTypeColumn
          key={pauseType.id}
          pauseType={pauseType}
          onReserve={
            boardActions.handleReserveClick
          }
          onStart={
            boardActions.handleStart
          }
          onFinish={
            boardActions.handleFinish
          }
        />
      ))}

      <ReservePauseModal
        open={boardActions.open}
        pauseType={
          boardActions.selectedPauseType
        }
        loading={boardActions.loading}
        onClose={
          boardActions.closeModal
        }
        onConfirm={
          boardActions.handleConfirm
        }
      />

    </main>
  );
}
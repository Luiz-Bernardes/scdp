"use client";

import { useState } from "react";

import { PauseBoard, PauseType } from "@/types/board";

import { PauseTypeColumn } from "./PauseTypeColumn";
import { ReservePauseModal } from "./ReservePauseModal";

import { PageTitle } from "@/components/ui/PageTitle";

import { useReservePause } from "@/hooks/useReservePause";

type Props = {
  board: PauseBoard;
};

export function Board({
  board
}: Props) {

  const [open, setOpen] = useState(false);

  const [
    selectedPauseType,
    setSelectedPauseType
  ] = useState<PauseType | null>(null);

  const {
    reserve,
    loading
  } = useReservePause();

  function handleReserveClick(
    pauseType: PauseType
  ) {
    setSelectedPauseType(pauseType);
    setOpen(true);
  }

  async function handleConfirm(
    duration?: number
  ) {
    if (!selectedPauseType) return;

    await reserve(
      selectedPauseType.id,
      duration
    );

    setOpen(false);
  }

  return (
    <main className="p-8">

      <PageTitle>
        Board de Pausas
      </PageTitle>

      {board.pause_types.map((pauseType) => (
        <PauseTypeColumn
          key={pauseType.id}
          pauseType={pauseType}
          onReserve={handleReserveClick}
        />
      ))}

      <ReservePauseModal
        open={open}
        pauseType={selectedPauseType}
        loading={loading}
        onClose={() => setOpen(false)}
        onConfirm={handleConfirm}
      />

    </main>
  );
}
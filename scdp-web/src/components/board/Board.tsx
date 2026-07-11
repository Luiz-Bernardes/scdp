"use client";

import { useState } from "react";

import { PauseBoard, PauseType } from "@/types/board";

import { PauseTypeColumn } from "./PauseTypeColumn";
import { ReservePauseModal } from "./ReservePauseModal";

import { PageTitle } from "@/components/ui/PageTitle";

import { useReservePause } from "@/hooks/useReservePause";
import { useStartPause } from "@/hooks/useStartPause";

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

  const {
    start
  } = useStartPause();

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

  async function handleStart(
    pauseId: number
  ) {
    try {
      await start(pauseId);

      alert(
        "Pausa iniciada! Atualize a página (F5)."
      );
    } catch (error) {
      console.error(error);

      alert(
        "Não foi possível iniciar a pausa."
      );
    }
  }

  function handleFinish(
    pauseId: number
  ) {
    console.log("finish", pauseId);
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
          onStart={handleStart}
          onFinish={handleFinish}
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
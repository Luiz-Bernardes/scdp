"use client";

import { useState } from "react";

import { PauseType } from "@/types/board";

import { useReservePause } from "./useReservePause";
import { useStartPause } from "./useStartPause";
import { useFinishPause } from "./useFinishPause";

export function useBoardActions() {

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

  const {
    finish
  } = useFinishPause();

  function handleReserveClick(
    pauseType: PauseType
  ) {
    setSelectedPauseType(pauseType);
    setOpen(true);
  }

  async function handleConfirm(
    duration?: number
  ) {
    if (!selectedPauseType) {
      return;
    }

    try {
      await reserve(
        selectedPauseType.id,
        duration
      );

      setOpen(false);
      // alert("Pausa reservada!");

    } catch (error: any) {
      alert(
        error.response?.data?.error ??
        "Erro ao reservar pausa."
      );
    }
  }

  async function handleStart(
    pauseId: number
  ) {
    try {

      await start(pauseId);
      //alert("Pausa iniciada!");

    } catch (error: any) {
      alert(
        error.response?.data?.error ??
        "Erro ao iniciar pausa."
      );
    }
  }

  async function handleFinish(
    pauseId: number
  ) {
    try {

      await finish(pauseId);
      // alert("Pausa finalizada!");

    } catch (error: any) {
      alert(
        error.response?.data?.error ??
        "Erro ao finalizar pausa."
      );
    }
  }

  function closeModal() {
    setOpen(false);
  }

  return {
    open,
    loading,
    selectedPauseType,

    handleReserveClick,
    handleConfirm,
    handleStart,
    handleFinish,

    closeModal
  };

}
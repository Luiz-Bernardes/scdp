"use client";

import { useEffect, useState } from "react";

type LivePause = {
  status: string;
  remainingSeconds: number;
  overtimeSeconds: number;
  progressPercentage: number;
};

export function useLivePause(
  slot: PauseSlot
) {
  const [state, setState] =
    useState<LivePause>(
      calculateState(slot)
    );

  useEffect(() => {

    setState(
      calculateState(slot)
    );

    const interval = setInterval(() => {
      setState(
        calculateState(slot)
      );
    }, 1000);

    return () => clearInterval(interval);

  }, [slot]);

  return state;
}

function calculateState(
  slot: PauseSlot
): LivePause {

  if (
    !slot.expires_at ||
    !slot.selected_duration_minutes
  ) {
    return {
      status: slot.status,
      remainingSeconds: 0,
      overtimeSeconds: 0,
      progressPercentage: 0
    };
  }

  const now = Date.now();

  const expiresAt =
    new Date(slot.expires_at).getTime();

  const remaining =
    Math.floor(
      (expiresAt - now) / 1000
    );

  const totalSeconds =
    slot.selected_duration_minutes * 60;

  const elapsed =
    totalSeconds - remaining;

  const progress =
    Math.min(
      100,
      Math.max(
        0,
        (elapsed / totalSeconds) * 100
      )
    );

  if (remaining > 0) {
    return {
      status: "running",
      remainingSeconds: remaining,
      overtimeSeconds: 0,
      progressPercentage: progress
    };
  }

  return {
    status: "expired",
    remainingSeconds: 0,
    overtimeSeconds: Math.abs(remaining),
    progressPercentage: 100
  };
}
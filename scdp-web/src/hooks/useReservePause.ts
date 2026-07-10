"use client";

import { useState } from "react";
import { reservePause } from "@/services/pause-service";

export function useReservePause() {
  const [loading, setLoading] = useState(false);

  async function reserve(
    pauseTypeId: number,
    selectedDurationMinutes?: number
  ) {
    setLoading(true);

    try {
      await reservePause({
        pauseTypeId,
        selectedDurationMinutes
      });

      return true;
    } finally {
      setLoading(false);
    }
  }

  return {
    reserve,
    loading
  };
}
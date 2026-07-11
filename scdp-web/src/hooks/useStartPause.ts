"use client";

import { useState } from "react";
import { startPause } from "@/services/pause-service";

export function useStartPause() {
  const [loading, setLoading] = useState(false);

  async function start(
    pauseId: number
  ) {
    setLoading(true);

    try {
      await startPause(pauseId);
    } finally {
      setLoading(false);
    }
  }

  return {
    start,
    loading
  };
}
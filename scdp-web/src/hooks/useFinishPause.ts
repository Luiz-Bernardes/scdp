"use client";

import { useState } from "react";

import { finishPause } from "@/services/pause-service";

export function useFinishPause() {
  const [loading, setLoading] = useState(false);

  async function finish(
    pauseId: number
  ) {
    setLoading(true);

    try {
      await finishPause(pauseId);
    } finally {
      setLoading(false);
    }
  }

  return {
    finish,
    loading
  };
}
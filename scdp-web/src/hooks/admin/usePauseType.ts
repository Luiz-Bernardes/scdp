"use client";

import { useCallback, useEffect, useState } from "react";

import {
  getAdminPauseType
} from "@/services/admin/pause-type-service";

import {
  AdminPauseType
} from "@/types/admin";

export function usePauseType(id: number) {
  const [pauseType, setPauseType] =
    useState<AdminPauseType | null>(null);

  const [loading, setLoading] =
    useState(true);

  const loadPauseType = useCallback(
    async () => {
      setLoading(true);

      try {
        const data =
          await getAdminPauseType(id);

        setPauseType(data);
      } finally {
        setLoading(false);
      }
    },
    [id]
  );

  useEffect(() => {
    loadPauseType();
  }, [loadPauseType]);

  return {
    pauseType,
    loading,
    refresh: loadPauseType
  };
}
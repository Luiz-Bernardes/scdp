"use client";

import { useCallback, useEffect, useState } from "react";

import {
  getAdminPauseTypes
} from "@/services/admin/pause-type-service";

import {
  AdminPauseType
} from "@/types/admin";

export function usePauseTypes() {
  const [pauseTypes, setPauseTypes] =
    useState<AdminPauseType[]>([]);

  const [loading, setLoading] =
    useState(true);

  const loadPauseTypes = useCallback(
    async () => {
      setLoading(true);

      try {
        const data =
          await getAdminPauseTypes();

        setPauseTypes(data);
      } finally {
        setLoading(false);
      }
    },
    []
  );

  useEffect(() => {
    loadPauseTypes();
  }, [loadPauseTypes]);

  return {
    pauseTypes,
    loading,
    refresh: loadPauseTypes
  };
}
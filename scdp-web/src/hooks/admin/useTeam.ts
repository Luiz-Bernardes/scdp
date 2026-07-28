"use client";

import {
  useCallback,
  useEffect,
  useState
} from "react";

import { AdminTeam } from "@/types/admin";

import {
  getAdminTeam
} from "@/services/admin/team-service";

export function useTeam(
  id: number
) {

  const [team, setTeam] =
    useState<AdminTeam>();

  const [loading, setLoading] =
    useState(true);

  const loadTeam =
    useCallback(async () => {

      try {

        const data =
          await getAdminTeam(id);

        setTeam(data);

      } finally {

        setLoading(false);

      }

    }, [id]);

  useEffect(() => {

    loadTeam();

  }, [loadTeam]);

  return {

    team,

    loading,

    refresh: loadTeam

  };

}
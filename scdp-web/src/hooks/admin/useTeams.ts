"use client";

import {
  useCallback,
  useEffect,
  useState
} from "react";

import { AdminTeam } from "@/types/admin";

import {
  getAdminTeams
} from "@/services/admin/team-service";

export function useTeams() {

  const [teams, setTeams] =
    useState<AdminTeam[]>([]);

  const [loading, setLoading] =
    useState(true);

  const loadTeams =
    useCallback(async () => {

      try {

        const data =
          await getAdminTeams();

        setTeams(data);

      } finally {

        setLoading(false);

      }

    }, []);

  useEffect(() => {

    loadTeams();

  }, [loadTeams]);

  return {

    teams,

    loading,

    refresh: loadTeams

  };

}
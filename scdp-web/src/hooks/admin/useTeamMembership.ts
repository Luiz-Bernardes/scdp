"use client";

import {
  useCallback,
  useEffect,
  useState
} from "react";

import {
  getAdminTeamMembership
} from "@/services/admin/team-membership-service";

import {
  AdminTeamMembership
} from "@/types/admin";

export function useTeamMembership(
  id: number
) {

  const [
    membership,
    setMembership
  ] = useState<AdminTeamMembership | null>(null);

  const [
    loading,
    setLoading
  ] = useState(true);

  const loadMembership =
    useCallback(async () => {

      setLoading(true);

      try {

        const data =
          await getAdminTeamMembership(id);

        setMembership(data);

      } finally {

        setLoading(false);

      }

    }, [id]);

  useEffect(() => {

    loadMembership();

  }, [loadMembership]);

  return {
    membership,
    loading,
    refresh: loadMembership
  };

}
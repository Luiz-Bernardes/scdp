"use client";

import { useCallback, useEffect, useState } from "react";

import {
  getAdminTeamMemberships
} from "@/services/admin/team-membership-service";

import {
  AdminTeamMembership
} from "@/types/admin";

export function useTeamMemberships() {

  const [
    memberships,
    setMemberships
  ] = useState<AdminTeamMembership[]>([]);

  const [
    loading,
    setLoading
  ] = useState(true);

  const loadMemberships =
    useCallback(async () => {

      setLoading(true);

      try {

        const data =
          await getAdminTeamMemberships();

        setMemberships(data);

      } finally {

        setLoading(false);

      }

    }, []);

  useEffect(() => {

    loadMemberships();

  }, [loadMemberships]);

  return {
    memberships,
    loading,
    refresh: loadMemberships
  };

}
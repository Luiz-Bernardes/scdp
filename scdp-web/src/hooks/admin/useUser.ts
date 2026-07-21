"use client";

import {
  useCallback,
  useEffect,
  useState
} from "react";

import {
  getAdminUser
} from "@/services/admin/user-service";

import {
  AdminUser
} from "@/types/admin";

export function useUser(
  id: number
) {

  const [user, setUser] =
    useState<AdminUser>();

  const [loading, setLoading] =
    useState(true);

  const loadUser =
    useCallback(async () => {

      try {

        const data =
          await getAdminUser(id);

        setUser(data);

      } finally {

        setLoading(false);

      }

    }, [id]);

  useEffect(() => {
    loadUser();
  }, [loadUser]);

  return {

    user,

    loading,

    refresh: loadUser

  };

}
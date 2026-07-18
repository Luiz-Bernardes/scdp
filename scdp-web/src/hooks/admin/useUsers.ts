"use client";

import {
  useCallback,
  useEffect,
  useState
} from "react";

import {
  getAdminUsers
} from "@/services/admin/user-service";

import {
  AdminUser
} from "@/types/admin";

export function useUsers() {

  const [users, setUsers] =
    useState<AdminUser[]>([]);

  const [loading, setLoading] =
    useState(true);

  const loadUsers =
    useCallback(async () => {

      try {

        const data =
          await getAdminUsers();

        setUsers(data);

      } finally {

        setLoading(false);

      }

    }, []);

  useEffect(() => {
    loadUsers();
  }, [loadUsers]);

  return {

    users,

    loading,

    refresh: loadUsers

  };

}
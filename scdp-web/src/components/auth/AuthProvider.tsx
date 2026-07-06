"use client";

import { useEffect } from "react";
import { api } from "@/lib/api";
import { useAuthStore } from "@/stores/auth-store";

export function AuthProvider({
  children
}: {
  children: React.ReactNode;
}) {
  const setAuth = useAuthStore((state) => state.setAuth);
  const setInitialized = useAuthStore(
    (state) => state.setInitialized
  );

  useEffect(() => {
    const token = localStorage.getItem("token");

    if (!token) {
      setInitialized(true);
      return;
    }

    api
      .get("/me", {
        headers: {
          Authorization: `Bearer ${token}`
        }
      })
      .then((response) => {
        setAuth(token, response.data);
      })
      .catch(() => {
        localStorage.removeItem("token");
        setInitialized(true);
      });

  }, [setAuth, setInitialized]);

  return children;
}
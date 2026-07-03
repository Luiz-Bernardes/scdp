"use client";

import { useEffect } from "react";
import { useRouter, useSearchParams } from "next/navigation";

import { api } from "@/lib/api";
import { useAuthStore } from "@/stores/auth-store";

export default function AuthCallbackPage() {
  const router = useRouter();
  const searchParams = useSearchParams();

  const setAuth = useAuthStore((state) => state.setAuth);

  useEffect(() => {
    const token = searchParams.get("token");

    if (!token) {
      router.push("/");
      return;
    }

    localStorage.setItem("token", token);

    api
      .get("/me", {
        headers: {
          Authorization: `Bearer ${token}`
        }
      })
      .then((response) => {
        setAuth(token, response.data);

        router.push("/dashboard");
      })
      .catch(() => {
        localStorage.removeItem("token");
        router.push("/");
      });
  }, [router, searchParams, setAuth]);

  return (
    <main className="flex min-h-screen items-center justify-center">
      <p>Autenticando...</p>
    </main>
  );
}
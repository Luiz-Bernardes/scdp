"use client";

import { ReactNode } from "react";

import { useAuthStore } from "@/stores/auth-store";

type Props = {
  children: ReactNode;
};

export function RequireAuth({
  children
}: Props) {
  const user = useAuthStore((state) => state.user);

  if (!user) {
    return null;
  }

  return <>{children}</>;
}
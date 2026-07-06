"use client";

import { ReactNode } from "react";

import { can } from "@/permissions/can";
import { Permission } from "@/permissions/permissions";
import { useAuthStore } from "@/stores/auth-store";
import { EmptyState } from "@/components/ui/EmptyState";
import { AccessDenied } from "@/components/auth/AccessDenied";
import { Loading } from "@/components/ui/Loading";

type Props = {
  permission: Permission;
  children: ReactNode;
};

export function RequirePermission({
  permission,
  children
}: Props) {
  const user = useAuthStore((state) => state.user);

  const initialized = useAuthStore(
      (state) => state.initialized
  );

  if (!initialized) {
      return <Loading />;
  }

  if (!can(user, permission)) {
      return <AccessDenied />;
  }

  return <>{children}</>;
}
"use client";

import { ReactNode } from "react";

import { can } from "@/permissions/can";
import { Permission } from "@/permissions/permissions";
import { useAuthStore } from "@/stores/auth-store";
import { EmptyState } from "@/components/ui/EmptyState";

type Props = {
  permission: Permission;
  children: ReactNode;
};

export function RequirePermission({
  permission,
  children
}: Props) {
  const user = useAuthStore((state) => state.user);

  if (!can(user, permission)) {
      return (
          <EmptyState
              title="Acesso negado"
              description="Você não possui permissão para acessar esta página."
          />
      );
  }

  return <>{children}</>;
}
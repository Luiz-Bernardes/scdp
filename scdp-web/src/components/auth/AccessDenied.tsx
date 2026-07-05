"use client";

import { EmptyState } from "@/components/ui/EmptyState";

export function AccessDenied() {
  return (
    <EmptyState
      title="Acesso negado"
      description="Você não possui permissão para acessar esta página."
    />
  );
}
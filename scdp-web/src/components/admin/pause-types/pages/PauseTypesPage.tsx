"use client";

import Link from "next/link";

import { Button } from "@/components/ui/Button";
import { Loading } from "@/components/ui/Loading";

import { usePauseTypes } from "@/hooks/admin/usePauseTypes";
import { usePauseTypeActions } from "@/hooks/admin/usePauseTypeActions";

import { PauseTypesTable } from "../table/PauseTypesTable";

export function PauseTypesPage() {
  const {
    pauseTypes,
    loading,
    refresh
  } = usePauseTypes();

  const {
    deletePauseType
  } = usePauseTypeActions();

  async function handleDelete(id: number) {
    await deletePauseType(id);
    refresh();
  }

  if (loading) {
    return <Loading />;
  }

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <h1 className="text-2xl font-bold">
          Tipos de Pausa
        </h1>

        <Link href="/admin/pause-types/new">
          <Button>
            Novo tipo de pausa
          </Button>
        </Link>
      </div>

      <PauseTypesTable
        pauseTypes={pauseTypes}
        onDelete={handleDelete}
      />
    </div>
  );
}
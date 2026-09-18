"use client";

import { useRouter } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import { useTeams } from "@/hooks/admin/useTeams";
import { usePauseTypeActions } from "@/hooks/admin/usePauseTypeActions";

import {
  PauseTypeForm,
  PauseTypeFormValues
} from "../form/PauseTypeForm";

export function NewPauseTypePage() {
  const router = useRouter();

  const {
    teams,
    loading: teamsLoading
  } = useTeams();

  const {
    createPauseType,
    loading
  } = usePauseTypeActions();

  async function handleSubmit(
    values: PauseTypeFormValues
  ) {
    await createPauseType(values);

    router.push("/admin/pause-types");
  }

  if (teamsLoading) {
    return <Loading />;
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">
        Novo tipo de pausa
      </h1>

      <PauseTypeForm
        teams={teams}
        loading={loading}
        onSubmit={handleSubmit}
      />
    </div>
  );
}
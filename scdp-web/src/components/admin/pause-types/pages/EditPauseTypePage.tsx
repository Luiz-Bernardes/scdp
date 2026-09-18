"use client";

import { useRouter } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import { useTeams } from "@/hooks/admin/useTeams";
import { usePauseType } from "@/hooks/admin/usePauseType";
import { usePauseTypeActions } from "@/hooks/admin/usePauseTypeActions";

import {
  PauseTypeForm,
  PauseTypeFormValues
} from "../form/PauseTypeForm";

type Props = {
  id: number;
};

export function EditPauseTypePage({
  id
}: Props) {
  const router = useRouter();

  const {
    pauseType,
    loading: pauseTypeLoading
  } = usePauseType(id);

  const {
    teams,
    loading: teamsLoading
  } = useTeams();

  const {
    updatePauseType,
    loading
  } = usePauseTypeActions();

  async function handleSubmit(
    values: PauseTypeFormValues
  ) {
    await updatePauseType({
      id,
      ...values
    });

    router.push("/admin/pause-types");
  }

  if (
    pauseTypeLoading ||
    teamsLoading
  ) {
    return <Loading />;
  }

  if (!pauseType) {
    return null;
  }

  return (
    <div className="space-y-6">
      <h1 className="text-2xl font-bold">
        Editar tipo de pausa
      </h1>

      <PauseTypeForm
        mode="edit"
        initialValues={{
          name: pauseType.name,
          team_id: pauseType.team_id,
          has_time_limit:
            pauseType.has_time_limit,
          max_duration_minutes:
            pauseType.max_duration_minutes,
          max_concurrent:
            pauseType.max_concurrent,
          requires_queue:
            pauseType.requires_queue,
          active: pauseType.active
        }}
        teams={teams}
        loading={loading}
        onSubmit={handleSubmit}
      />
    </div>
  );
}
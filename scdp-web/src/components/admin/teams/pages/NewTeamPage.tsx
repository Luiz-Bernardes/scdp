"use client";

import { useRouter } from "next/navigation";

import {
  TeamForm,
  TeamFormValues
} from "../form/TeamForm";

import {
  useTeamActions
} from "@/hooks/admin/useTeamActions";

export function NewTeamPage() {

  const router =
    useRouter();

  const {

    createTeam,

    loading

  } = useTeamActions({

    onSuccess() {

      router.push(
        "/admin/teams"
      );

    }

  });

  async function handleSubmit(
    values: TeamFormValues
  ) {

    await createTeam(values);

  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">
        Novo Time
      </h1>

      <TeamForm
        mode="create"
        loading={loading}
        onSubmit={handleSubmit}
      />

    </div>

  );

}
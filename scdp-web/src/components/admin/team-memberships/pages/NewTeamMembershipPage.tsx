"use client";

import { useRouter } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import {
  TeamMembershipForm,
  TeamMembershipFormValues
} from "../form/TeamMembershipForm";

import {
  useTeams
} from "@/hooks/admin/useTeams";

import {
  useTeamMembershipActions
} from "@/hooks/admin/useTeamMembershipActions";

export function NewTeamMembershipPage() {

  const router =
    useRouter();

  const {
    teams,
    loading: teamsLoading
  } = useTeams();

  const {
    createMembership,
    loading: saving
  } = useTeamMembershipActions({

    onSuccess() {

      router.push(
        "/admin/team-memberships"
      );

    }

  });

  async function handleSubmit(
    values: TeamMembershipFormValues
  ) {

    await createMembership(
      values
    );

  }

  if (teamsLoading) {
    return <Loading />;
  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">
        Novo convite
      </h1>

      <TeamMembershipForm
        mode="create"
        teams={teams}
        loading={saving}
        onSubmit={handleSubmit}
      />

    </div>

  );

}
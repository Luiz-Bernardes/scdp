"use client";

import { useRouter } from "next/navigation";
import { useParams } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import {
  TeamMembershipForm,
  TeamMembershipFormValues
} from "../form/TeamMembershipForm";

import {
  useTeamMembership
} from "@/hooks/admin/useTeamMembership";

import {
  useTeamMembershipActions
} from "@/hooks/admin/useTeamMembershipActions";

import {
  useTeams
} from "@/hooks/admin/useTeams";

export function EditTeamMembershipPage() {

  const router = useRouter();
  const params = useParams();

  const id = Number(params.id);

  const {
    membership,
    loading: membershipLoading
  } = useTeamMembership(id);

  const {
    teams,
    loading: teamsLoading
  } = useTeams();

  const {
    updateMembership,
    loading: saving
  } = useTeamMembershipActions({

    onSuccess() {

      router.push(
        "/admin/team-memberships"
      );

    }

  });

  if (
    membershipLoading ||
    teamsLoading ||
    !membership
  ) {
    return <Loading />;
  }

  async function handleSubmit(
    values: TeamMembershipFormValues
  ) {

    await updateMembership({

      id,

      ...values

    });

  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">
        Editar convite
      </h1>

      <TeamMembershipForm
        mode="edit"

        teams={teams}

        initialValues={{

          email: membership.email,

          team_id: membership.team_id,

          team_role: membership.team_role

        }}

        loading={saving}

        onSubmit={handleSubmit}

      />

    </div>

  );

}
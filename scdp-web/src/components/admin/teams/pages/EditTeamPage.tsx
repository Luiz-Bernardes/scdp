"use client";

import { useRouter } from "next/navigation";
import { useParams } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import {
  TeamForm,
  TeamFormValues
} from "../form/TeamForm";

import {
  useTeam
} from "@/hooks/admin/useTeam";

import {
  useTeamActions
} from "@/hooks/admin/useTeamActions";

export function EditTeamPage() {

  const router =
    useRouter();

  const params =
    useParams();

  const id =
    Number(params.id);

  const {

    team,

    loading

  } = useTeam(id);

  const {

    updateTeam,

    loading: saving

  } = useTeamActions({

    onSuccess() {

      router.push(
        "/admin/teams"
      );

    }

  });

  if (loading || !team) {
    return <Loading />;
  }

  async function handleSubmit(
    values: TeamFormValues
  ) {

    await updateTeam({

      id,

      ...values

    });

  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">

        Editar Time

      </h1>

      <TeamForm

        mode="edit"

        initialValues={{

          name: team.name

        }}

        loading={saving}

        onSubmit={handleSubmit}

      />

    </div>

  );

}
"use client";

import Link from "next/link";

import { Button } from "@/components/ui/Button";
import { Loading } from "@/components/ui/Loading";

import { useTeams } from "@/hooks/admin/useTeams";
import { useTeamActions } from "@/hooks/admin/useTeamActions";

import { TeamsTable } from "../table/TeamsTable";

export function TeamsPage() {

  const {
    teams,
    loading,
    refresh
  } = useTeams();

  const {
    deleteTeam
  } = useTeamActions();

  async function handleDelete(
    id: number
  ) {

    await deleteTeam(id);

    refresh();

  }

  if (loading) {
    return <Loading />;
  }

  return (

    <div className="space-y-6">

      <div className="flex items-center justify-between">

        <h1 className="text-2xl font-bold">
          Times
        </h1>

        <Link href="/admin/teams/new">

          <Button>
            Novo time
          </Button>

        </Link>

      </div>

      <TeamsTable
        teams={teams}
        onDelete={handleDelete}
      />

    </div>

  );

}
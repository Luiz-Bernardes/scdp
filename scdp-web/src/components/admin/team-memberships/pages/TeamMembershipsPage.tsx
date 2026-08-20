"use client";

import Link from "next/link";

import { Button } from "@/components/ui/Button";
import { Loading } from "@/components/ui/Loading";

import {
  useTeamMemberships
} from "@/hooks/admin/useTeamMemberships";

import {
  useTeamMembershipActions
} from "@/hooks/admin/useTeamMembershipActions";

import { TeamMembershipsTable } from "../table/TeamMembershipsTable";

export function TeamMembershipsPage() {

  const {
    memberships,
    loading,
    refresh
  } = useTeamMemberships();

  const {
    deleteMembership
  } = useTeamMembershipActions();

  async function handleDelete(
    id: number
  ) {

    await deleteMembership(id);

    refresh();

  }

  if (loading) {
    return <Loading />;
  }

  return (

    <div className="space-y-6">

      <div className="flex items-center justify-between">

        <h1 className="text-2xl font-bold">
          Membros das Equipes
        </h1>

        <Link
          href="/admin/team-memberships/new"
        >

          <Button>
            Novo convite
          </Button>

        </Link>

      </div>

      <TeamMembershipsTable
        memberships={memberships}
        onDelete={handleDelete}
      />

    </div>

  );

}
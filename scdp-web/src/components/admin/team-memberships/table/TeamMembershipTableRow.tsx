"use client";

import Link from "next/link";
import { AdminTeamMembership } from "@/types/admin";
import { DeleteTeamMembershipButton } from "./DeleteTeamMembershipButton";

type Props = {
  membership: AdminTeamMembership;

  onDelete(
    id: number
  ): void;
};

export function TeamMembershipTableRow({
  membership,
  onDelete
}: Props) {

  return (

    <tr className="border-b">

      <td className="p-3">
        {membership.email}
      </td>

      <td className="p-3">
        {membership.team_name}
      </td>

      <td className="p-3">
        {membership.team_role === "leader"
          ? "Líder"
          : "Membro"}
      </td>

      <td className="p-3 text-center">

        {membership.user_id
          ? "Vinculado"
          : "Pendente"}

      </td>

      <td className="space-x-3 p-3 text-center">

        <Link
          href={`/admin/team-memberships/${membership.id}/edit`}
          className="text-blue-600 hover:underline"
        >
          Editar
        </Link>

        <DeleteTeamMembershipButton
          id={membership.id}
          email={membership.email}
          onDelete={onDelete}
        />

      </td>

    </tr>

  );

}
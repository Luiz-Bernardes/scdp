"use client";

import Link from "next/link";

import { AdminTeam } from "@/types/admin";

import { DeleteTeamButton } from "./DeleteTeamButton";

type Props = {
  team: AdminTeam;

  onDelete(
    id: number
  ): void;
};

export function TeamTableRow({
  team,
  onDelete
}: Props) {

  return (

    <tr className="border-b">

      <td className="p-3">
        {team.name}
      </td>

      <td className="p-3 text-center">

        {team.active
          ? "Ativo"
          : "Inativo"}

      </td>

      <td className="space-x-3 p-3 text-center">

        <Link
          href={`/admin/teams/${team.id}/edit`}
          className="text-blue-600 hover:underline"
        >
          Editar
        </Link>

        <DeleteTeamButton
          id={team.id}
          name={team.name}
          onDelete={onDelete}
        />

      </td>

    </tr>

  );

}
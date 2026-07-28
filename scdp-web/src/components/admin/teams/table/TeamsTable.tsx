"use client";

import { Card } from "@/components/ui/Card";

import { AdminTeam } from "@/types/admin";

import { TeamTableRow } from "./TeamTableRow";

type Props = {
  teams: AdminTeam[];

  onDelete(
    id: number
  ): void;
};

export function TeamsTable({
  teams,
  onDelete
}: Props) {

  return (

    <Card className="overflow-hidden">

      <table className="w-full border-collapse">

        <thead>

          <tr className="border-b bg-gray-50">

            <th className="p-3 text-left">
              Nome
            </th>

            <th className="p-3 text-center">
              Status
            </th>

            <th className="p-3 text-center">
              Ações
            </th>

          </tr>

        </thead>

        <tbody>

          {teams.map((team) => (

            <TeamTableRow
              key={team.id}
              team={team}
              onDelete={onDelete}
            />

          ))}

        </tbody>

      </table>

    </Card>

  );

}
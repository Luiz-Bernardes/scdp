"use client";

import { Card } from "@/components/ui/Card";
import { AdminTeamMembership } from "@/types/admin";
import { TeamMembershipTableRow } from "./TeamMembershipTableRow";

type Props = {
  memberships: AdminTeamMembership[];

  onDelete(
    id: number
  ): void;
};

export function TeamMembershipsTable({
  memberships,
  onDelete
}: Props) {

  return (

    <Card className="overflow-hidden">

      <table className="w-full border-collapse">

        <thead>

          <tr className="border-b bg-gray-50">

            <th className="p-3 text-left">
              Email
            </th>

            <th className="p-3 text-left">
              Equipe
            </th>

            <th className="p-3 text-left">
              Cargo
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

          {memberships.map((membership) => (

            <TeamMembershipTableRow
              key={membership.id}
              membership={membership}
              onDelete={onDelete}
            />

          ))}

        </tbody>

      </table>

    </Card>

  );

}
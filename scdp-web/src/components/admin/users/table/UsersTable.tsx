"use client";

import { Card } from "@/components/ui/Card";

import { AdminUser } from "@/types/admin";

import { UserTableRow } from "./UserTableRow";

type Props = {
  users: AdminUser[];

  onDelete(
    id: number
  ): void;
};

export function UsersTable({
  users,
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

            <th className="p-3 text-left">
              Email
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

          {users.map((user) => (

            <UserTableRow
              key={user.id}
              user={user}
              onDelete={onDelete}
            />

          ))}

        </tbody>

      </table>

    </Card>

  );

}
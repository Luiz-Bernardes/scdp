"use client";

import Link from "next/link";

import { AdminUser } from "@/types/admin";

type Props = {
  users: AdminUser[];
};

export function UsersTable({
  users
}: Props) {

  return (

    <table className="w-full border-collapse bg-white">

      <thead>

        <tr className="border-b">

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

          <tr
            key={user.id}
            className="border-b"
          >

            <td className="p-3">
              {user.name}
            </td>

            <td className="p-3">
              {user.email}
            </td>

            <td className="p-3">
              {user.role}
            </td>

            <td className="p-3 text-center">

              {user.active
                ? "Ativo"
                : "Inativo"}

            </td>

            <td className="space-x-2 p-3 text-center">

              <Link
                href={`/admin/users/${user.id}/edit`}
                className="text-blue-600"
              >
                Editar
              </Link>

              <button
                className="text-red-600"
              >
                Desativar
              </button>

            </td>

          </tr>

        ))}

      </tbody>

    </table>

  );

}
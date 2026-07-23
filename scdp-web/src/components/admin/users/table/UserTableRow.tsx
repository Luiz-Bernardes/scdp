"use client";

import Link from "next/link";

import { AdminUser } from "@/types/admin";

import { roleLabel } from "@/permissions/role-label";

import { DeleteUserButton } from "./DeleteUserButton";

type Props = {
  user: AdminUser;

  onDelete(
    id: number
  ): void;
};

export function UserTableRow({
  user,
  onDelete
}: Props) {

  return (

    <tr className="border-b">

      <td className="p-3">
        {user.name}
      </td>

      <td className="p-3">
        {user.email}
      </td>

      <td className="p-3">
        {roleLabel(user.role)}
      </td>

      <td className="p-3 text-center">

        {user.active
          ? "Ativo"
          : "Inativo"}

      </td>

      <td className="space-x-3 p-3 text-center">

        <Link
          href={`/admin/users/${user.id}/edit`}
          className="text-blue-600 hover:underline"
        >
          Editar
        </Link>

        <DeleteUserButton
          user={user}
          onDelete={onDelete}
        />

      </td>

    </tr>

  );

}
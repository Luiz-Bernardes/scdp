"use client";

import Link from "next/link";

import { Loading } from "@/components/ui/Loading";
import { UsersTable } from "@/components/admin/users/UsersTable";

import { useUsers } from "@/hooks/admin/useUsers";

export default function AdminUsersPage() {

  const {
    users,
    loading
  } = useUsers();

  if (loading) {
    return <Loading />;
  }

  return (

    <div className="space-y-6">

      <div className="flex items-center justify-between">

        <h1 className="text-2xl font-bold">
          Usuários
        </h1>

        <Link
          href="/admin/users/new"
          className="
            rounded-lg
            bg-blue-600
            px-4
            py-2
            text-white
          "
        >
          Novo usuário
        </Link>

      </div>

      <UsersTable
        users={users}
      />

    </div>

  );

}
"use client";

import Link from "next/link";

import { Button } from "@/components/ui/Button";
import { Loading } from "@/components/ui/Loading";

import { useUsers } from "@/hooks/admin/useUsers";
import { useUserActions } from "@/hooks/admin/useUserActions";

import { UsersTable } from "../table/UsersTable";

export function UsersPage() {

  const {
    users,
    loading,
    refresh
  } = useUsers();

  const {
    deleteUser
  } = useUserActions();

  async function handleDelete(
    id: number
  ) {

    await deleteUser(id);

    refresh();

  }

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
        >

          <Button>
            Novo usuário
          </Button>

        </Link>

      </div>

      <UsersTable
        users={users}
        onDelete={handleDelete}
      />

    </div>

  );

}
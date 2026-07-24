"use client";

import { useRouter } from "next/navigation";

import { useUserActions } from "@/hooks/admin/useUserActions";

import {
  UserForm,
  UserFormValues
} from "../form/UserForm";

export function NewUserPage() {

  const router = useRouter();

  const {
    createUser,
    loading
  } = useUserActions({

    onSuccess() {

      router.push(
        "/admin/users"
      );

    }

  });

  async function handleSubmit(
    values: UserFormValues
  ) {

    await createUser(values);

  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">
        Novo usuário
      </h1>

      <UserForm
        mode="create"
        loading={loading}
        onSubmit={handleSubmit}
      />

    </div>

  );

}
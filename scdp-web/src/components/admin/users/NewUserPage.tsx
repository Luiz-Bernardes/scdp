"use client";

import { useRouter } from "next/navigation";

import {
  UserForm,
  UserFormValues
} from "./UserForm";

import {
  useUserActions
} from "@/hooks/admin/useUserActions";

export function NewUserPage() {

  const router =
    useRouter();

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
        Novo Usuário
      </h1>

      <UserForm
        loading={loading}
        onSubmit={handleSubmit}
      />

    </div>

  );

}
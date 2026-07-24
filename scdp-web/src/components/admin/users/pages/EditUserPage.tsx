"use client";

import { useParams } from "next/navigation";
import { useRouter } from "next/navigation";

import { Loading } from "@/components/ui/Loading";

import { useUser } from "@/hooks/admin/useUser";
import { useUserActions } from "@/hooks/admin/useUserActions";

import {
  UserForm,
  UserFormValues
} from "../form/UserForm";

export function EditUserPage() {

  const router = useRouter();

  const params = useParams();

  const id = Number(params.id);

  const {
    user,
    loading
  } = useUser(id);

  const {
    updateUser,
    loading: saving
  } = useUserActions({

    onSuccess() {

      router.push(
        "/admin/users"
      );

    }

  });

  if (loading || !user) {
    return <Loading />;
  }

  async function handleSubmit(
    values: UserFormValues
  ) {

    await updateUser({
      id,
      ...values
    });

  }

  return (

    <div className="max-w-2xl space-y-6">

      <h1 className="text-2xl font-bold">
        Editar usuário
      </h1>

      <UserForm
        mode="edit"
        initialValues={{
          name: user.name,
          email: user.email,
          role: user.role
        }}
        loading={saving}
        onSubmit={handleSubmit}
      />

    </div>

  );

}
import { api } from "@/lib/api";

type CreateUserParams = {
  name: string;
  email: string;
  role: UserRole;
};

type UpdateUserParams = {
  id: number;
  name: string;
  email: string;
  role: UserRole;
};

export async function getAdminUsers() {
  const response =
    await api.get("/admin/users");

  return response.data;
}

export async function getAdminUser(
  id: number
) {
  const response =
    await api.get(
      `/admin/users/${id}`
    );

  return response.data;
}

export async function createAdminUser(
  params: CreateUserParams
) {
  const response =
    await api.post(
      "/admin/users",
      {
        user: params
      }
    );

  return response.data;
}

export async function updateAdminUser({
  id,
  ...params
}: UpdateUserParams) {
  const response =
    await api.patch(
      `/admin/users/${id}`,
      {
        user: params
      }
    );

  return response.data;
}

export async function deleteAdminUser(
  id: number
) {
  await api.delete(
    `/admin/users/${id}`
  );
}
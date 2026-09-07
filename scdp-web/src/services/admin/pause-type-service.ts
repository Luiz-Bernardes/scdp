import { api } from "@/lib/api";

import {
  AdminPauseType
} from "@/types/admin";

export type PauseTypeParams = {
  name: string;
  team_id: number;
  has_time_limit: boolean;
  max_duration_minutes: number | null;
  max_concurrent: number;
  requires_queue: boolean;
  active: boolean;
};

export type UpdatePauseTypeParams =
  PauseTypeParams & {
    id: number;
  };

export async function getAdminPauseTypes() {
  const response =
    await api.get("/admin/pause_types");

  return response.data as AdminPauseType[];
}

export async function getAdminPauseType(id: number) {
  const response =
    await api.get(`/admin/pause_types/${id}`);

  return response.data as AdminPauseType;
}

export async function createAdminPauseType(
  params: PauseTypeParams
) {
  const response =
    await api.post(
      "/admin/pause_types",
      {
        pause_type: params
      }
    );

  return response.data as AdminPauseType;
}

export async function updateAdminPauseType(
  params: UpdatePauseTypeParams
) {
  const { id, ...pauseType } = params;

  const response =
    await api.patch(
      `/admin/pause_types/${id}`,
      {
        pause_type: pauseType
      }
    );

  return response.data as AdminPauseType;
}

export async function deleteAdminPauseType(id: number) {
  await api.delete(`/admin/pause_types/${id}`);
}
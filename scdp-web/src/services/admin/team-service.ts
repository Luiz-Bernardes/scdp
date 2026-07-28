"use client";

import { api } from "@/lib/api";
import { AdminTeam } from "@/types/admin";

export type TeamParams = {
  name: string;
};

export type UpdateTeamParams = TeamParams & {
  id: number;
};

export async function getAdminTeams() {

  const response =
    await api.get("/admin/teams");

  return response.data as AdminTeam[];

}

export async function getAdminTeam(
  id: number
) {

  const response =
    await api.get(`/admin/teams/${id}`);

  return response.data as AdminTeam;

}

export async function createAdminTeam(
  params: TeamParams
) {

  const response =
    await api.post(
      "/admin/teams",
      {
        team: params
      }
    );

  return response.data as AdminTeam;

}

export async function updateAdminTeam(
  params: UpdateTeamParams
) {

  const { id, ...team } = params;

  const response =
    await api.patch(
      `/admin/teams/${id}`,
      {
        team
      }
    );

  return response.data as AdminTeam;

}

export async function deleteAdminTeam(
  id: number
) {

  await api.delete(
    `/admin/teams/${id}`
  );

}
import { api } from "@/lib/api";

import {
  AdminTeamMembership
} from "@/types/admin";

export type TeamMembershipParams = {
  email: string;
  team_id: number;
  team_role: "leader" | "member";
};

export type UpdateTeamMembershipParams =
  TeamMembershipParams & {
    id: number;
  };

export async function getAdminTeamMemberships() {

  const response =
    await api.get(
      "/admin/team_memberships"
    );

  return response.data as AdminTeamMembership[];

}

export async function getAdminTeamMembership(
  id: number
) {

  const response =
    await api.get(
      `/admin/team_memberships/${id}`
    );

  return response.data as AdminTeamMembership;

}

export async function createAdminTeamMembership(
  params: TeamMembershipParams
) {

  const response =
    await api.post(
      "/admin/team_memberships",
      {
        team_membership: params
      }
    );

  return response.data as AdminTeamMembership;

}

export async function updateAdminTeamMembership(
  params: UpdateTeamMembershipParams
) {

  const {
    id,
    ...teamMembership
  } = params;

  const response =
    await api.patch(
      `/admin/team_memberships/${id}`,
      {
        team_membership: teamMembership
      }
    );

  return response.data as AdminTeamMembership;

}

export async function deleteAdminTeamMembership(
  id: number
) {

  await api.delete(
    `/admin/team_memberships/${id}`
  );

}
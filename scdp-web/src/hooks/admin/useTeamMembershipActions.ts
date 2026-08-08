"use client";

import { useAsyncAction } from "@/hooks/useAsyncAction";

import {
  createAdminTeamMembership,
  updateAdminTeamMembership,
  deleteAdminTeamMembership
} from "@/services/admin/team-membership-service";

type Options = {
  onSuccess?(): void;
};

export function useTeamMembershipActions(
  options?: Options
) {

  const {
    execute,
    loading
  } = useAsyncAction({
    onSuccess: options?.onSuccess
  });

  function createMembership(
    params: Parameters<
      typeof createAdminTeamMembership
    >[0]
  ) {

    return execute(
      () =>
        createAdminTeamMembership(
          params
        )
    );

  }

  function updateMembership(
    params: Parameters<
      typeof updateAdminTeamMembership
    >[0]
  ) {

    return execute(
      () =>
        updateAdminTeamMembership(
          params
        )
    );

  }

  function deleteMembership(
    id: number
  ) {

    return execute(
      () =>
        deleteAdminTeamMembership(
          id
        )
    );

  }

  return {
    createMembership,
    updateMembership,
    deleteMembership,
    loading
  };

}
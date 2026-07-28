"use client";

import { useAsyncAction } from "@/hooks/useAsyncAction";

import {

  createAdminTeam,

  updateAdminTeam,

  deleteAdminTeam

} from "@/services/admin/team-service";

type Options = {

  onSuccess?(): void;

};

export function useTeamActions(
  options?: Options
) {

  const {

    execute,

    loading

  } = useAsyncAction({

    onSuccess: options?.onSuccess

  });

  function createTeam(
    params: Parameters<
      typeof createAdminTeam
    >[0]
  ) {

    return execute(
      () => createAdminTeam(params)
    );

  }

  function updateTeam(
    params: Parameters<
      typeof updateAdminTeam
    >[0]
  ) {

    return execute(
      () => updateAdminTeam(params)
    );

  }

  function deleteTeam(
    id: number
  ) {

    return execute(
      () => deleteAdminTeam(id)
    );

  }

  return {

    createTeam,

    updateTeam,

    deleteTeam,

    loading

  };

}
"use client";

import { useAsyncAction } from "@/hooks/useAsyncAction";

import {
  createAdminUser,
  updateAdminUser,
  deleteAdminUser

} from "@/services/admin/user-service";

type Options = {

  onSuccess?(): void;

};

export function useUserActions(
  options?: Options
) {

  const {

    execute,

    loading

  } = useAsyncAction({

    onSuccess: options?.onSuccess

  });

  function createUser(
    params: Parameters<
      typeof createAdminUser
    >[0]
  ) {

    return execute(
      () => createAdminUser(params)
    );

  }

  function updateUser(
    params: Parameters<
      typeof updateAdminUser
    >[0]
  ) {

    return execute(
      () => updateAdminUser(params)
    );

  }

  function deleteUser(
    id: number
  ) {

    return execute(
      () => deleteAdminUser(id)
    );

  }

  return {

    createUser,

    updateUser,

    deleteUser,

    loading

  };

}
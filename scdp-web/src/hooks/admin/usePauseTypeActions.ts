"use client";

import { useAsyncAction } from "@/hooks/useAsyncAction";

import {
  createAdminPauseType,
  updateAdminPauseType,
  deleteAdminPauseType
} from "@/services/admin/pause-type-service";

type Options = {
  onSuccess?(): void;
};

export function usePauseTypeActions(
  options?: Options
) {
  const {
    execute,
    loading
  } = useAsyncAction({
    onSuccess: options?.onSuccess
  });

  function createPauseType(
    params: Parameters<
      typeof createAdminPauseType
    >[0]
  ) {
    return execute(
      () => createAdminPauseType(params)
    );
  }

  function updatePauseType(
    params: Parameters<
      typeof updateAdminPauseType
    >[0]
  ) {
    return execute(
      () => updateAdminPauseType(params)
    );
  }

  function deletePauseType(
    id: number
  ) {
    return execute(
      () => deleteAdminPauseType(id)
    );
  }

  return {
    createPauseType,
    updatePauseType,
    deletePauseType,
    loading
  };
}
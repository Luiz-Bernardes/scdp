"use client";

import { useState } from "react";

type Options = {
  onSuccess?(): void;
  onError?(error: unknown): void;
};

export function useAsyncAction(
  options?: Options
) {

  const [loading, setLoading] =
    useState(false);

  async function execute(
    action: () => Promise<void>
  ) {

    try {

      setLoading(true);

      await action();

      options?.onSuccess?.();

    } catch (error) {

      options?.onError?.(error);

      throw error;

    } finally {

      setLoading(false);

    }

  }

  return {
    execute,
    loading
  };

}
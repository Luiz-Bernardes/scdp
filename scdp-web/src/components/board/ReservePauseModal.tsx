"use client";

import { useState } from "react";

type Props = {
  pauseType: PauseType | null;
  open: boolean;
  loading: boolean;

  onClose(): void;

  onConfirm(
    selectedDuration?: number
  ): void;
};

export function ReservePauseModal({
  pauseType,
  open,
  loading,
  onClose,
  onConfirm
}: Props) {
  const [duration, setDuration] =
    useState(10);

  if (!open || !pauseType) {
    return null;
  }

  return (
    <div className="fixed inset-0 flex items-center justify-center bg-black/40">

      <div className="w-[420px] rounded-lg bg-white p-6">

        <h2 className="text-xl font-semibold">
          Reservar pausa
        </h2>

        <p className="mt-2 text-sm text-gray-500">
          {pauseType.name}
        </p>

        {pauseType.has_time_limit && (
          <div className="mt-6">

            <label className="mb-2 block text-sm">
              Duração
            </label>

            <select
              className="w-full rounded border p-2"
              value={duration}
              onChange={(e) =>
                setDuration(Number(e.target.value))
              }
            >
              <option value={10}>10 min</option>
              <option value={20}>20 min</option>
              <option value={30}>30 min</option>
              <option value={60}>60 min</option>
            </select>

          </div>
        )}

        <div className="mt-8 flex justify-end gap-2">

          <button
            onClick={onClose}
            className="rounded border px-4 py-2"
          >
            Cancelar
          </button>

          <button
            disabled={loading}
            onClick={() =>
              onConfirm(
                pauseType.has_time_limit
                  ? duration
                  : undefined
              )
            }
            className="rounded bg-blue-600 px-4 py-2 text-white"
          >
            Reservar
          </button>

        </div>

      </div>

    </div>
  );
}
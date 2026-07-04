"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";

import { api } from "@/lib/api";
import { useAuthStore } from "@/stores/auth-store";

type Slot = {
  pause_id: number;
  user_name: string;
  selected_duration_minutes: number;
  started_at: string;
  expires_at: string | null;
  remaining_seconds: number | null;
} | null;

type PauseType = {
  id: number;
  name: string;
  slots: Slot[];
};

type PauseBoard = {
  team_id: number;
  pause_types: PauseType[];
};

export default function BoardPage() {
  const router = useRouter();

  const user = useAuthStore((state) => state.user);

  const [board, setBoard] = useState<PauseBoard | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!user) {
      router.push("/");
      return;
    }

    if (user.team_ids.length === 0) {
      setLoading(false);
      return;
    }

    api
      .get(`/teams/${user.team_ids[0]}/pause_board`)
      .then((response) => {
        setBoard(response.data);
      })
      .finally(() => {
        setLoading(false);
      });
  }, [router, user]);

  if (loading) {
    return <p className="p-8">Carregando...</p>;
  }

  if (!board) {
    return (
      <main className="p-8">
        <h1 className="text-3xl font-bold">
          Board de Pausas
        </h1>

        <p className="mt-4">
          Nenhum board encontrado.
        </p>
      </main>
    );
  }

  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold mb-8">
        Board de Pausas
      </h1>

      {board.pause_types.map((pauseType) => (
        <section
          key={pauseType.id}
          className="mb-10"
        >
          <h2 className="text-xl font-semibold mb-4">
            {pauseType.name}
          </h2>

          <div className="grid grid-cols-3 gap-4">
            {pauseType.slots.map((slot, index) => (
              <div
                key={index}
                className="rounded-lg border p-4 min-h-[140px]"
              >
                {slot ? (
                  <>
                    <h3 className="font-bold">
                      {slot.user_name}
                    </h3>

                    <p>
                      Duração:
                      {" "}
                      {slot.selected_duration_minutes} min
                    </p>

                    <p>
                      Restante:
                      {" "}
                      {slot.remaining_seconds}s
                    </p>

                    <p className="text-xs text-gray-500 mt-3">
                      Slot ocupado
                    </p>
                  </>
                ) : (
                  <div className="flex items-center justify-center h-full text-gray-400">
                    Slot livre
                  </div>
                )}
              </div>
            ))}
          </div>
        </section>
      ))}
    </main>
  );
}
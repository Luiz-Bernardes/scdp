"use client";

import { useEffect } from "react";
import { Dispatch, SetStateAction } from "react";

import { PauseBoard } from "@/types/board";
import { createCable } from "@/lib/cable";

export function usePauseBoardCable(
  teamId: number | undefined,
  setBoard: Dispatch<
    SetStateAction<PauseBoard | null>
  >
) {

  useEffect(() => {
    if (!teamId) return;

    const cable = createCable();

    const subscription =
      cable.subscriptions.create(
        {
          channel: "TeamChannel",
          team_id: teamId
        },
        {
          connected() {
            console.log("🟢 Connected");
          },

          disconnected() {
            console.log("🔴 Disconnected");
          },

          received(data) {
            console.log("Broadcast:", data);

            if (data.type !== "pause_state_updated") {
              return;
            }

            setBoard((current) => {
              if (!current) return current;

              return {
                ...current,
                pause_types: current.pause_types.map(
                  (pauseType) => {
                    if (pauseType.id !== data.pause_type_id) {
                      return pauseType;
                    }

                    return {
                      ...pauseType,
                      slots: data.slots
                    };
                  }
                )
              };
            });
          }
        }
      );

    return () => {
      subscription.unsubscribe();
    };
  }, [teamId]);
}
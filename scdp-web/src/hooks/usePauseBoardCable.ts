"use client";

import { useEffect } from "react";

import { createCable } from "@/lib/cable";

export function usePauseBoardCable(
  teamId?: number
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
            console.log(data);
          }
        }
      );

    return () => {
      subscription.unsubscribe();
    };
  }, [teamId]);
}
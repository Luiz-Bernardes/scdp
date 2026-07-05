"use client";

import { useAuthStore } from "@/stores/auth-store";
import { roleLabel } from "@/utils/roles";

export function UserMenu() {
  const user = useAuthStore((state) => state.user);

  if (!user) {
    return null;
  }

  return (
    <div className="text-right">
      <p className="font-semibold">
        {user.name}
      </p>

      <p className="text-sm opacity-80">
        {roleLabel(user.role)}
      </p>

    </div>
  );
}
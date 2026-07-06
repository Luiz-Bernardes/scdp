"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import { useAuthStore } from "@/stores/auth-store";

export function UserMenu() {
  const router = useRouter();

  const user = useAuthStore((state) => state.user);
  const logout = useAuthStore((state) => state.logout);

  const [open, setOpen] = useState(false);

  if (!user) {
    return null;
  }

  function handleLogout() {
    logout();

    router.push("/");
  }

  return (
    <div className="relative">

      <button
        onClick={() => setOpen(!open)}
        className="rounded-lg px-3 py-2 hover:bg-gray-100"
      >
        <div className="text-right">
          <p className="font-semibold">
            {user.name}
          </p>

          <p className="text-xs text-gray-500">
            {user.role}
          </p>
        </div>
      </button>

      {open && (
        <div className="absolute right-0 mt-2 w-56 rounded-lg border bg-white shadow-lg">

          <button
            className="w-full px-4 py-3 text-left hover:bg-gray-50"
          >
            Perfil
          </button>

          <button
            className="w-full px-4 py-3 text-left hover:bg-gray-50"
          >
            Configurações
          </button>

          <hr />

          <button
            onClick={handleLogout}
            className="w-full px-4 py-3 text-left text-red-600 hover:bg-red-50"
          >
            Sair
          </button>

        </div>
      )}

    </div>
  );
}
"use client";

import { useAuthStore } from "@/stores/auth-store";

export function AdminHeader() {

  const user =
    useAuthStore(
      (state) => state.user
    );

  return (

    <header
      className="
        flex
        h-16
        items-center
        justify-between
        border-b
        bg-white
        px-6
      "
    >

      <h2 className="text-lg font-semibold">
        Painel Administrativo
      </h2>

      <span className="text-sm text-gray-600">
        {user?.name}
      </span>

    </header>

  );
}
"use client";

import { useAuthStore } from "@/stores/auth-store";
import Link from "next/link";

export default function DashboardPage() {
  const user = useAuthStore((state) => state.user);

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold">
        Olá, {user?.name}
      </h1>

      <p>Email: {user?.email}</p>
      <p>Role: {user?.role}</p>

      <p>
        Teams: {user?.team_ids.join(", ")}
      </p>

      <Link
        href="/board"
        className="inline-block mt-8 rounded bg-blue-600 px-4 py-2 text-white"
      >
        Abrir Board de Pausas
      </Link>
    </main>
  );
}
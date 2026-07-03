"use client";

import { useAuthStore } from "@/stores/auth-store";

export default function DashboardPage() {
  const user = useAuthStore((state) => state.user);

  return (
    <main className="p-8">
      <h1 className="text-2xl font-bold">
        Olá, {user?.name}
      </h1>

      <p>Email: {user?.email}</p>
      <p>Role: {user?.role}</p>
    </main>
  );
}
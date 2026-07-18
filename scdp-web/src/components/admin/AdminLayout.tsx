"use client";

import { ReactNode } from "react";

import { AdminSidebar } from "./AdminSidebar";
import { AdminHeader } from "./AdminHeader";

type Props = {
  children: ReactNode;
};

export function AdminLayout({
  children
}: Props) {
  return (
    <div className="flex min-h-screen bg-gray-100">

      <AdminSidebar />

      <div className="flex flex-1 flex-col">

        <AdminHeader />

        <main className="flex-1 p-6">
          {children}
        </main>

      </div>

    </div>
  );
}
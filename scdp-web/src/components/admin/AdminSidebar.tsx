"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

const items = [
  {
    label: "Usuários",
    href: "/admin/users"
  },
  {
    label: "Times",
    href: "/admin/teams"
  },
  {
    label: "Tipos de pausa",
    href: "/admin/pause-types"
  },
  {
    label: "Membros",
    href: "/admin/team-memberships"
  },
  {
    label: "Relatórios",
    href: "/admin/reports"
  }
];

export function AdminSidebar() {

  const pathname = usePathname();

  return (

    <aside className="w-64 bg-white border-r">

      <div className="p-6 border-b">

        <h1 className="text-xl font-bold">
          Administração
        </h1>

      </div>

      <nav className="flex flex-col p-2">

        {items.map((item) => (

          <Link
            key={item.href}
            href={item.href}
            className={`
              rounded-lg
              px-4
              py-3
              transition

              ${
                pathname.startsWith(item.href)
                  ? "bg-blue-600 text-white"
                  : "hover:bg-gray-100"
              }
            `}
          >
            {item.label}
          </Link>

        ))}

      </nav>

    </aside>

  );
}
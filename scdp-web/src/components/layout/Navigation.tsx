"use client";

import Link from "next/link";

import { useAuthStore } from "@/stores/auth-store";
import { can } from "@/permissions/can";
import { navigationItems } from "@/navigation/items";

export function Navigation() {
  const user = useAuthStore((state) => state.user);

  if (!user) {
    return null;
  }

  return (
    <nav className="flex gap-6">
      {navigationItems
        .filter((item) => can(user, item.permission))
        .map((item) => (
          <Link
            key={item.href}
            href={item.href}
            className="text-sm font-medium hover:text-pink-600"
          >
            {item.label}
          </Link>
        ))}
    </nav>
  );
}
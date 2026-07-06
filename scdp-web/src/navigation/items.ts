import { Permission } from "@/permissions/permissions";

export type NavigationItem = {
  label: string;
  href: string;
  permission: Permission;
};

export const navigationItems: NavigationItem[] = [
  {
    label: "Board",
    href: "/board",
    permission: "use_pause_board"
  },
  {
    label: "Dashboard",
    href: "/dashboard",
    permission: "view_dashboard"
  }
];
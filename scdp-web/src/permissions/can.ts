import { User } from "@/types/user";
import { Permission, permissions } from "./permissions";

export function can(
  user: User | null | undefined,
  permission: Permission
): boolean {
  if (!user) {
    return false;
  }

  return permissions[user.role].includes(permission);
}
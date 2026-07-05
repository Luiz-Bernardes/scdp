export function roleLabel(role: string) {
  switch (role) {
    case "super_admin":
      return "Super Administrador";

    case "admin":
      return "Administrador";

    case "supervisor":
      return "Supervisor";

    case "agent":
      return "Agente";

    default:
      return role;
  }
}
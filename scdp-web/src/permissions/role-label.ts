export function roleLabel(
    role: UserRole
) {

    switch (role) {
        case "agent":
            return "Agente";
        case "supervisor":
            return "Supervisor";
        case "admin":
            return "Administrador";
        case "super_admin":
            return "Super Administrador";
    }

}
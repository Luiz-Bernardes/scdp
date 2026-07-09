import { Badge } from "@/components/ui/Badge";

type Props = {
  status: string;
};

const labels: Record<string, string> = {
  reserved: "Reservado",
  running: "Em pausa",
  expired: "Tempo excedido",
  waiting_return: "Aguardando retorno",
  finished: "Finalizada"
};

const classes: Record<string, string> = {
  reserved: "bg-yellow-100 text-yellow-800",
  running: "bg-green-100 text-green-800",
  expired: "bg-red-100 text-red-800",
  waiting_return: "bg-orange-100 text-orange-800",
  finished: "bg-gray-100 text-gray-700"
};

export function PauseStatusBadge({
  status
}: Props) {
  const badgeClass =
    classes[status] ??
    "bg-gray-100 text-gray-700";

  const label =
    labels[status] ??
    status;

  return (
    <Badge className={badgeClass}>
      {label}
    </Badge>
  );
}
import { Badge } from "@/components/ui/Badge";

type Props = {
  status: string;
};

const labels: Record<string, string> = {
  reserved: "Reservado",
  active: "Em pausa",
  waiting_return: "Aguardando retorno"
};

const classes: Record<string, string> = {
  reserved: "bg-yellow-100 text-yellow-800",
  active: "bg-green-100 text-green-800",
  waiting_return: "bg-red-100 text-red-800"
};

export function PauseStatusBadge({
  status
}: Props) {
  return (
    <Badge className={classes[status]}>
      {labels[status] ?? status}
    </Badge>
  );
}
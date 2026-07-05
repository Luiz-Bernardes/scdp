import { Card } from "@/components/ui/Card";
import { Badge } from "@/components/ui/Badge";
import { Slot } from "@/types/board";

import { EmptySlotCard } from "./EmptySlotCard";
import { PauseTimer } from "./PauseTimer";

type Props = {
  slot: Slot;
};

export function PauseSlotCard({
  slot
}: Props) {
  if (!slot) {
    return <EmptySlotCard />;
  }

  return (
    <Card className="min-h-[140px]">
      <h3 className="font-bold">
        {slot.user_name}
      </h3>

      <p>
        Duração: {slot.selected_duration_minutes} min
      </p>

      <p>
        Restante:{" "}
        <PauseTimer
          remainingSeconds={slot.remaining_seconds}
        />
      </p>

      <Badge>
         Slot ocupado
      </Badge>

    </Card>
  );
}
import { Card } from "@/components/ui/Card";
import { EmptySlotCard } from "./EmptySlotCard";
import { PauseStatusBadge } from "./PauseStatusBadge";
import { PauseTimer } from "./PauseTimer";

type Props = {
  slot: PauseSlot | null;
};

export function PauseSlotCard({
  slot
}: Props) {
  
  console.log(slot);
  if (!slot) {
    return <EmptySlotCard />;
  }

  return (
    <Card className="min-h-[170px] flex flex-col justify-between">

      <div className="space-y-2">

        <div className="flex items-center justify-between">
          <h3 className="font-semibold">
            {slot.user_name}
          </h3>

          <PauseStatusBadge
            status={slot.status}
          />
        </div>

        <p className="text-sm text-gray-600">
          Duração:{" "}
          {slot.selected_duration_minutes
            ? `${slot.selected_duration_minutes} min`
            : "Sem limite"}
        </p>

        <p className="text-sm">
          Tempo restante:{" "}
          <PauseTimer
            remainingSeconds={slot.remaining_seconds}
          />
        </p>

      </div>

    </Card>
  );
}
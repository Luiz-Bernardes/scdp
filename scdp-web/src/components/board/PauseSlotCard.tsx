import { Card } from "@/components/ui/Card";
import { EmptySlotCard } from "./EmptySlotCard";
import { PauseStatusBadge } from "./PauseStatusBadge";
import { PauseTimer } from "./PauseTimer";
import { PauseProgressBar } from "./PauseProgressBar";
import { PauseActions } from "./PauseActions";

type Props = {
  slot: PauseSlot | null;
  pauseType: PauseType;
};

export function PauseSlotCard({
  slot,
  pauseType
}: Props) {
  
  if (!slot) {
    return (
      <EmptySlotCard
        pauseType={pauseType}
      />
    );
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

        <PauseProgressBar
          percentage={slot.progress_percentage}
        />

      </div>

      <PauseActions
        slot={slot}
      />

    </Card>
  );
}
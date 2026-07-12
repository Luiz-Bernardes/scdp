import { Card } from "@/components/ui/Card";
import { EmptySlotCard } from "./EmptySlotCard";
import { PauseStatusBadge } from "./PauseStatusBadge";
import { PauseTimer } from "./PauseTimer";
import { PauseProgressBar } from "./PauseProgressBar";
import { PauseActions } from "./PauseActions";
import { useLivePause } from "@/hooks/useLivePause";

type Props = {
  slot: PauseSlot | null;
  pauseType: PauseType;

  onReserve(
    pauseType: PauseType
  ): void;

  onStart(
      pauseId: number
    ): void;

  onFinish(
    pauseId: number
  ): void;
};

export function PauseSlotCard({
  slot,
  pauseType,
  onReserve,
  onStart,
  onFinish
}: Props) {
  
  if (!slot) {
    return (
      <EmptySlotCard
        pauseType={pauseType}
        onReserve={onReserve}
      />
    );
  }

  const live = useLivePause(slot);

  return (
    <Card className="min-h-[170px] flex flex-col justify-between">

      <div className="space-y-2">

        <div className="flex items-center justify-between">
          <h3 className="font-semibold">
            {slot.user_name}
          </h3>

          <PauseStatusBadge
            status={live.status}
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
            remainingSeconds={live.remainingSeconds}
          />
        </p>

        <PauseProgressBar
          percentage={live.progressPercentage}
        />

      </div>

      <PauseActions
        slot={slot}
        onStart={onStart}
        onFinish={onFinish}
      />

    </Card>
  );
}
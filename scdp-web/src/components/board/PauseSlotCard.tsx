import { EmptySlotCard } from "./EmptySlotCard";
import { OccupiedSlotCard } from "./OccupiedSlotCard";

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

  return (
    <OccupiedSlotCard
      slot={slot}
      onStart={onStart}
      onFinish={onFinish}
    />
  );
}
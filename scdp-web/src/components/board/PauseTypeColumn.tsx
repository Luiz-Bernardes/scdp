import { PauseType } from "@/types/board";
import { PauseSlotCard } from "./PauseSlotCard";
import { SectionTitle } from "@/components/ui/SectionTitle";

type Props = {
  pauseType: PauseType;

  onReserve(
    pauseType: PauseType
  ): void;
};

export function PauseTypeColumn({
  pauseType,
  onReserve
}: Props) {
  return (
    <section className="mb-10">
      <SectionTitle> {pauseType.name} </SectionTitle>

      <div className="grid grid-cols-3 gap-4">
        {pauseType.slots.map((slot, index) => (
          <PauseSlotCard
            key={index}
            slot={slot}
            pauseType={pauseType}
            onReserve={onReserve}
          />
        ))}
      </div>
    </section>
  );
}
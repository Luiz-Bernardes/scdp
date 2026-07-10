import { Card } from "@/components/ui/Card";

type Props = {
  pauseType: PauseType;

  onReserve(
    pauseType: PauseType
  ): void;
};

export function EmptySlotCard({
  pauseType,
  onReserve
}: Props) {
  return (
    <Card
      onClick={() => onReserve(pauseType)}
      className="
        min-h-[170px]
        cursor-pointer
        transition
        hover:border-blue-500
        hover:bg-blue-50
      "
    >
        <div className="flex h-full flex-col items-center justify-center">

            <div className="text-4xl">
                +
            </div>

            <p className="mt-2 text-gray-500">
                Reservar pausa
            </p>

        </div>
    </Card>
  );
}
type Props = {
  slot: PauseSlot;

  onStart(
    pauseId: number
  ): void;

  onFinish(
    pauseId: number
  ): void;
};

export function PauseActions({
  slot,
  onStart,
  onFinish
}: Props) {
  return (
    <div className="mt-4 flex gap-2">

      {slot.can_start && (
        <button
          onClick={() => {
            onStart(slot.pause_id)
          }}
          className="
            rounded
            bg-green-600
            px-3
            py-2
            text-sm
            text-white
          "
        >
          Iniciar
        </button>
      )}

      {slot.can_finish && (
        <button
          onClick={() => {
            onFinish(slot.pause_id)
          }}
          className="
            rounded
            bg-red-600
            px-3
            py-2
            text-sm
            text-white
          "
        >
          Finalizar
        </button>
      )}

    </div>
  );
}
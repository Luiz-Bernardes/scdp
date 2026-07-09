type Props = {
  slot: PauseSlot;
};

export function PauseActions({
  slot
}: Props) {
  return (
    <div className="mt-4 flex gap-2">

      {slot.can_start && (
        <button
          onClick={() => {
            console.log("start", slot.pause_id);
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
            console.log("finish", slot.pause_id);
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
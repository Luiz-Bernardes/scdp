import { PauseBoard } from "@/types/board";
import { PauseTypeColumn } from "./PauseTypeColumn";
import { PageTitle } from "@/components/ui/PageTitle";

type Props = {
  board: PauseBoard;
};

export function Board({
  board
}: Props) {
  return (
    <main className="p-8">
      <PageTitle>
          Board de Pausas
      </PageTitle>

      {board.pause_types.map((pauseType) => (
        <PauseTypeColumn
          key={pauseType.id}
          pauseType={pauseType}
        />
      ))}
    </main>
  );
}
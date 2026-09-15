"use client";

import { Button } from "@/components/ui/Button";

type Props = {
  id: number;
  name: string;
  onDelete(id: number): void | Promise<void>;
};

export function DeletePauseTypeButton({
  id,
  name,
  onDelete
}: Props) {
  async function handleClick() {
    const confirmed =
      window.confirm(
        `Deseja remover o tipo de pausa "${name}"?`
      );

    if (!confirmed) return;

    await onDelete(id);
  }

  return (
    <Button
      variant="danger"
      onClick={handleClick}
    >
      Remover
    </Button>
  );
}
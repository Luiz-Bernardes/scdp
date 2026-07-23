"use client";

import { Button } from "@/components/ui/Button";

type Props = {
  id: number;
  name: string;

  onDelete(
    id: number
  ): void | Promise<void>;
};

export function DeleteUserButton({
  id,
  name,
  onDelete
}: Props) {

  async function handleClick() {

    const confirmed =
      window.confirm(
        `Deseja desativar o usuário "${name}"?`
      );

    if (!confirmed) {
      return;
    }

    await onDelete(id);

  }

  return (

    <Button
      variant="danger"
      onClick={handleClick}
    >
      Desativar
    </Button>

  );

}
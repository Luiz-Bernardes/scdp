"use client";

import { Button } from "@/components/ui/Button";

type Props = {
  id: number;
  email: string;

  onDelete(
    id: number
  ): void | Promise<void>;
};

export function DeleteTeamMembershipButton({
  id,
  email,
  onDelete
}: Props) {

  async function handleClick() {

    const confirmed =
      window.confirm(
        `Deseja remover o vínculo do usuário "${email}"?`
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
      Remover
    </Button>

  );

}
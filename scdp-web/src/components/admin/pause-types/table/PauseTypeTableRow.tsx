"use client";

import Link from "next/link";

import { AdminPauseType } from "@/types/admin";

import { DeletePauseTypeButton } from "./DeletePauseTypeButton";

type Props = {
  pauseType: AdminPauseType;
  onDelete(id: number): void;
};

export function PauseTypeTableRow({
  pauseType,
  onDelete
}: Props) {
  return (
    <tr className="border-b">
      <td className="p-3">
        {pauseType.name}
      </td>

      <td className="p-3">
        {pauseType.team_name}
      </td>

      <td className="p-3 text-center">
        {pauseType.has_time_limit
          ? `${pauseType.max_duration_minutes} min`
          : "Sem limite"}
      </td>

      <td className="p-3 text-center">
        {pauseType.max_concurrent}
      </td>

      <td className="p-3 text-center">
        {pauseType.requires_queue
          ? "Sim"
          : "Não"}
      </td>

      <td className="p-3 text-center">
        {pauseType.active
          ? "Ativo"
          : "Inativo"}
      </td>

      <td className="space-x-3 p-3 text-center">
        <Link
          href={`/admin/pause-types/${pauseType.id}/edit`}
          className="text-blue-600 hover:underline"
        >
          Editar
        </Link>

        <DeletePauseTypeButton
          id={pauseType.id}
          name={pauseType.name}
          onDelete={onDelete}
        />
      </td>
    </tr>
  );
}
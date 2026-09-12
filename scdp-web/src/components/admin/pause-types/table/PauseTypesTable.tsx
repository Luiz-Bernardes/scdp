"use client";

import { Card } from "@/components/ui/Card";
import { AdminPauseType } from "@/types/admin";
import { PauseTypeTableRow } from "./PauseTypeTableRow";

type Props = {
  pauseTypes: AdminPauseType[];
  onDelete(id: number): void;
};

export function PauseTypesTable({
  pauseTypes,
  onDelete
}: Props) {
  return (
    <Card className="overflow-hidden">
      <table className="w-full border-collapse">
        <thead>
          <tr className="border-b bg-gray-50">
            <th className="p-3 text-left">
              Nome
            </th>

            <th className="p-3 text-left">
              Equipe
            </th>

            <th className="p-3 text-center">
              Duração
            </th>

            <th className="p-3 text-center">
              Máximo simultâneo
            </th>

            <th className="p-3 text-center">
              Fila
            </th>

            <th className="p-3 text-center">
              Status
            </th>

            <th className="p-3 text-center">
              Ações
            </th>
          </tr>
        </thead>

        <tbody>
          {pauseTypes.map((pauseType) => (
            <PauseTypeTableRow
              key={pauseType.id}
              pauseType={pauseType}
              onDelete={onDelete}
            />
          ))}
        </tbody>
      </table>
    </Card>
  );
}
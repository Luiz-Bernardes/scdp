"use client";

import { useState } from "react";

import { Button } from "@/components/ui/Button";
import { Card } from "@/components/ui/Card";
import { Input } from "@/components/ui/Input";
import { Select } from "@/components/ui/Select";
import { FormField } from "@/components/ui/FormField";

import { AdminTeam } from "@/types/admin";

export type PauseTypeFormValues = {
  name: string;
  team_id: number;
  has_time_limit: boolean;
  max_duration_minutes: number | null;
  max_concurrent: number;
  requires_queue: boolean;
  active: boolean;
};

type Props = {
  mode?: "create" | "edit";
  initialValues?: PauseTypeFormValues;
  teams: AdminTeam[];
  loading: boolean;
  onSubmit(
    values: PauseTypeFormValues
  ): void | Promise<void>;
};

const defaultValues: PauseTypeFormValues = {
  name: "",
  team_id: 0,
  has_time_limit: false,
  max_duration_minutes: null,
  max_concurrent: 1,
  requires_queue: false,
  active: true
};

export function PauseTypeForm({
  mode = "create",
  initialValues = defaultValues,
  teams,
  loading,
  onSubmit
}: Props) {
  const [name, setName] =
    useState(initialValues.name);

  const [teamId, setTeamId] =
    useState(initialValues.team_id);

  const [hasTimeLimit, setHasTimeLimit] =
    useState(initialValues.has_time_limit);

  const [maxDurationMinutes, setMaxDurationMinutes] =
    useState(
      initialValues.max_duration_minutes
    );

  const [maxConcurrent, setMaxConcurrent] =
    useState(initialValues.max_concurrent);

  const [requiresQueue, setRequiresQueue] =
    useState(initialValues.requires_queue);

  const [active, setActive] =
    useState(initialValues.active);

  function handleSubmit(
    event: React.FormEvent
  ) {
    event.preventDefault();

    onSubmit({
      name,
      team_id: teamId,
      has_time_limit: hasTimeLimit,
      max_duration_minutes: hasTimeLimit
        ? maxDurationMinutes
        : null,
      max_concurrent: maxConcurrent,
      requires_queue: requiresQueue,
      active
    });
  }

  return (
    <Card className="p-6">
      <form
        onSubmit={handleSubmit}
        className="space-y-6"
      >
        <FormField
          label="Nome"
          required
        >
          <Input
            value={name}
            onChange={(e) =>
              setName(e.target.value)
            }
          />
        </FormField>

        <FormField
          label="Equipe"
          required
        >
          <Select
            value={teamId}
            onChange={(e) =>
              setTeamId(
                Number(e.target.value)
              )
            }
          >
            <option value={0}>
              Selecione uma equipe
            </option>

            {teams.map((team) => (
              <option
                key={team.id}
                value={team.id}
              >
                {team.name}
              </option>
            ))}
          </Select>
        </FormField>

        <FormField
          label="Possui limite de tempo"
          required
        >
          <Select
            value={
              hasTimeLimit
                ? "true"
                : "false"
            }
            onChange={(e) =>
              setHasTimeLimit(
                e.target.value === "true"
              )
            }
          >
            <option value="false">
              Não
            </option>

            <option value="true">
              Sim
            </option>
          </Select>
        </FormField>

        {hasTimeLimit && (
          <FormField
            label="Duração máxima (minutos)"
            required
          >
            <Input
              type="number"
              min="1"
              value={
                maxDurationMinutes ?? ""
              }
              onChange={(e) =>
                setMaxDurationMinutes(
                  e.target.value
                    ? Number(e.target.value)
                    : null
                )
              }
            />
          </FormField>
        )}

        <FormField
          label="Máximo simultâneo"
          required
        >
          <Input
            type="number"
            min="1"
            value={maxConcurrent}
            onChange={(e) =>
              setMaxConcurrent(
                Number(e.target.value)
              )
            }
          />
        </FormField>

        <FormField
          label="Utiliza fila"
          required
        >
          <Select
            value={
              requiresQueue
                ? "true"
                : "false"
            }
            onChange={(e) =>
              setRequiresQueue(
                e.target.value === "true"
              )
            }
          >
            <option value="false">
              Não
            </option>

            <option value="true">
              Sim
            </option>
          </Select>
        </FormField>

        {mode === "edit" && (
          <FormField
            label="Status"
            required
          >
            <Select
              value={
                active
                  ? "true"
                  : "false"
              }
              onChange={(e) =>
                setActive(
                  e.target.value === "true"
                )
              }
            >
              <option value="true">
                Ativo
              </option>

              <option value="false">
                Inativo
              </option>
            </Select>
          </FormField>
        )}

        <Button
          type="submit"
          disabled={loading}
        >
          {loading
            ? "Salvando..."
            : mode === "edit"
              ? "Atualizar"
              : "Salvar"}
        </Button>
      </form>
    </Card>
  );
}
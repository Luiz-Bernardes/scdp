"use client";

import { useState } from "react";
import { Button } from "@/components/ui/Button";
import { Card } from "@/components/ui/Card";
import { Input } from "@/components/ui/Input";
import { Select } from "@/components/ui/Select";
import { FormField } from "@/components/ui/FormField";

import { AdminTeam } from "@/types/admin";

export type TeamMembershipRole =
  | "leader"
  | "member";

export type TeamMembershipFormValues = {
  email: string;
  team_id: number;
  team_role: TeamMembershipRole;
};

type Props = {
  mode?: "create" | "edit";

  initialValues?: TeamMembershipFormValues;

  teams: AdminTeam[];

  loading: boolean;

  onSubmit(
    values: TeamMembershipFormValues
  ): void | Promise<void>;
};

const defaultValues: TeamMembershipFormValues = {
  email: "",
  team_id: 0,
  team_role: "member"
};

export function TeamMembershipForm({
  mode = "create",
  initialValues = defaultValues,
  teams,
  loading,
  onSubmit
}: Props) {

  const [email, setEmail] =
    useState(initialValues.email);

  const [teamId, setTeamId] =
    useState(initialValues.team_id);

  const [teamRole, setTeamRole] =
    useState<TeamMembershipRole>(
      initialValues.team_role
    );

  function handleSubmit(
    event: React.FormEvent
  ) {

    event.preventDefault();

    onSubmit({

      email,

      team_id: teamId,

      team_role: teamRole

    });

  }

  return (

    <Card className="p-6">

      <form
        onSubmit={handleSubmit}
        className="space-y-6"
      >

        <FormField
          label="Email"
          required
        >

          <Input
            type="email"
            value={email}
            onChange={(e) =>
              setEmail(
                e.target.value
              )
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
                Number(
                  e.target.value
                )
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
          label="Cargo"
          required
        >

          <Select
            value={teamRole}
            onChange={(e) =>
              setTeamRole(
                e.target.value as TeamMembershipRole
              )
            }
          >

            <option value="member">
              Membro
            </option>

            <option value="leader">
              Líder
            </option>

          </Select>

        </FormField>

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
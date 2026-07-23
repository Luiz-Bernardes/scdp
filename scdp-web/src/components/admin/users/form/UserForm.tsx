"use client";

import { useState } from "react";
import { UserRole } from "@/types/admin";

import { Button } from "@/components/ui/Button";
import { Card } from "@/components/ui/Card";
import { Input } from "@/components/ui/Input";
import { Select } from "@/components/ui/Select";
import { FormField } from "@/components/ui/FormField";

import { RoleOptions } from "@/permissions/roles";
import { roleLabel } from "@/permissions/role-label";

export type UserFormValues = {
  name: string;
  email: string;
  role: UserRole;
};

type Props = {
  mode?: "create" | "edit";
  initialValues?: UserFormValues;
  loading: boolean;
  onSubmit(
    values: UserFormValues
  ): void | Promise<void>;
};

const defaultValues: UserFormValues = {
  name: "",
  email: "",
  role: "agent"
};

export function UserForm({
  mode = "create",
  initialValues = defaultValues,
  loading,
  onSubmit
}: Props) {

  const [name, setName] =
    useState(initialValues.name);

  const [email, setEmail] =
    useState(initialValues.email);

  const [role, setRole] =
    useState<UserRole>(
      initialValues.role
    );

  function handleSubmit(
    event: React.FormEvent
  ) {

    event.preventDefault();

    onSubmit({
      name,
      email,
      role
    });

  }

  return (
    <Card className="p-6">
      <form onSubmit={handleSubmit} className="space-y-6">

        <FormField label="Nome" required>
          <Input
            value={name}
            onChange={(e) =>
              setName(e.target.value)
            }
          />
        </FormField>

        <FormField label="Email" required>
          <Input
            type="email"
            value={email}
            onChange={(e) =>
              setEmail(e.target.value)
            }
          />
        </FormField>

        <FormField label="Cargo" required>
          <Select
            value={role}
            onChange={(e) =>
              setRole(
                e.target.value as UserRole
              )
            }
          >
            {RoleOptions.map((role) => (

              <option
                key={role}
                value={role}
              >
                {roleLabel(role)}
              </option>

            ))}
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
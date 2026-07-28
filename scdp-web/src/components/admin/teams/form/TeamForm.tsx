"use client";

import { useState } from "react";

import { Button } from "@/components/ui/Button";
import { Card } from "@/components/ui/Card";
import { FormField } from "@/components/ui/FormField";
import { Input } from "@/components/ui/Input";

export type TeamFormValues = {
  name: string;
};

type Props = {
  mode?: "create" | "edit";
  initialValues?: TeamFormValues;
  loading: boolean;

  onSubmit(
    values: TeamFormValues
  ): void | Promise<void>;
};

const defaultValues: TeamFormValues = {
  name: ""
};

export function TeamForm({
  mode = "create",
  initialValues = defaultValues,
  loading,
  onSubmit
}: Props) {

  const [name, setName] =
    useState(initialValues.name);

  function handleSubmit(
    event: React.FormEvent
  ) {

    event.preventDefault();

    onSubmit({
      name
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
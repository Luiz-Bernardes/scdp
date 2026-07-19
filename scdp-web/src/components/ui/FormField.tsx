import { ReactNode } from "react";
import { Label } from "./Label";

type Props = {
  label: string;
  required?: boolean;
  error?: string;
  children: ReactNode;
};

export function FormField({
  label,
  required = false,
  error,
  children
}: Props) {
  return (
    <div className="space-y-2">

      <Label>

        {label}

        {required && (
          <span className="text-red-500">
            {" "}*
          </span>
        )}

      </Label>

      {children}

      {error && (
        <p className="text-sm text-red-600">
          {error}
        </p>
      )}

    </div>
  );
}
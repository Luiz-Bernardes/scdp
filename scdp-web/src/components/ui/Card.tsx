import { ReactNode } from "react";

type Props = {
  children: ReactNode;
  className?: string;
};

export function Card({
  children,
  className = ""
}: Props) {
  return (
    <div
      className={`rounded-lg border p-4 ${className}`}
    >
      {children}
    </div>
  );
}
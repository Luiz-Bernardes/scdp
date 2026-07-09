import { HTMLAttributes } from "react";

type Props = HTMLAttributes<HTMLDivElement>;

export function Card({
  children,
  className = "",
  ...props
}: Props) {
  return (
    <div
      className={`rounded-lg border p-4 ${className}`}
      {...props}
    >
      {children}
    </div>
  );
}
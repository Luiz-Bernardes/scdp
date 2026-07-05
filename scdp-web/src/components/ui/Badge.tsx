type Props = {
  children: React.ReactNode;
};

export function Badge({
  children
}: Props) {
  return (
    <span className="inline-block rounded bg-gray-100 px-2 py-1 text-xs">
      {children}
    </span>
  );
}
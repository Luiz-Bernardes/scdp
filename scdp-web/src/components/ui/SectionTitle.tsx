type Props = {
  children: React.ReactNode;
};

export function SectionTitle({
  children
}: Props) {
  return (
    <h2 className="text-xl font-semibold mb-4">
      {children}
    </h2>
  );
}
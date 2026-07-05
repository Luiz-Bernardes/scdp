type Props = {
  children: React.ReactNode;
};

export function PageTitle({
  children
}: Props) {
  return (
    <h1 className="text-3xl font-bold mb-8">
      {children}
    </h1>
  );
}
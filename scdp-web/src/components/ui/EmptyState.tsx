type Props = {
  title: string;
  description: string;
};

export function EmptyState({
  title,
  description
}: Props) {
  return (
    <main className="p-8">
      <h1 className="text-3xl font-bold">
        {title}
      </h1>

      <p className="mt-4 text-gray-500">
        {description}
      </p>
    </main>
  );
}
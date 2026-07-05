type Props = {
  text?: string;
};

export function Loading({
  text = "Carregando..."
}: Props) {
  return (
    <div className="flex justify-center items-center min-h-[300px]">
      <p className="text-gray-500">
        {text}
      </p>
    </div>
  );
}
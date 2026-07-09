type Props = {
  percentage: number | null;
};

export function PauseProgressBar({
  percentage
}: Props) {
  if (percentage == null) {
    return null;
  }

  return (
    <div className="mt-2">
      <div className="h-2 w-full rounded bg-gray-200">
        <div
          className="h-2 rounded bg-green-500 transition-all"
          style={{
            width: `${percentage}%`
          }}
        />
      </div>
    </div>
  );
}
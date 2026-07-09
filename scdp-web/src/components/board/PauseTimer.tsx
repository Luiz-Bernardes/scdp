type Props = {
  remainingSeconds: number | null;
};

function format(seconds: number) {
  const minutes = Math.floor(seconds / 60);
  const secs = seconds % 60;

  return `${minutes.toString().padStart(2, "0")}:${secs
    .toString()
    .padStart(2, "0")}`;
}

export function PauseTimer({
  remainingSeconds
}: Props) {
  if (remainingSeconds == null) {
    return <>Sem limite</>;
  }

  return <>{format(remainingSeconds)}</>;
}
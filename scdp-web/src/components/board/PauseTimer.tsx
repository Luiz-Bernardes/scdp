type Props = {
  remainingSeconds: number | null;
};

export function PauseTimer({
  remainingSeconds
}: Props) {
  if (remainingSeconds == null) {
    return <>Sem limite</>;
  }

  return <>{remainingSeconds}s</>;
}
import { EditPauseTypePage } from "@/components/admin/pause-types";

type Props = {
  params: Promise<{
    id: string;
  }>;
};

export default async function Page({
  params
}: Props) {
  const { id } = await params;

  return (
    <EditPauseTypePage
      id={Number(id)}
    />
  );
}
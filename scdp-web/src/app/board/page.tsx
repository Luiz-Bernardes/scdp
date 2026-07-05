import BoardContent from "./BoardContent";
import { RequirePermission } from "@/components/auth/RequirePermission";

export default function BoardPage() {
  return (
    <RequirePermission permission="use_pause_board">
      <BoardContent />
    </RequirePermission>
  );
}
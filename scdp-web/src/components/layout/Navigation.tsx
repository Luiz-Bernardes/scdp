import Link from "next/link";

export function Navigation() {
  return (
    <nav className="flex gap-6">

      <Link href="/board">
        Board
      </Link>

    </nav>
  );
}
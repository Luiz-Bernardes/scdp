import { Logo } from "./Logo";
import { UserMenu } from "./UserMenu";

export function Header() {
  return (
    <header className="bg-[#480e2a] text-white">
      <div className="mx-auto flex h-16 max-w-7xl items-center justify-between px-8">
        <Logo />
        <UserMenu />
      </div>
    </header>
  );
}
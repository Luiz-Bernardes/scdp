import { ReactNode } from "react";

import { Header } from "./Header";
import { Footer } from "./Footer";

type Props = {
  children: ReactNode;
};

export function AppLayout({
  children
}: Props) {
  return (
    <div className="flex min-h-screen flex-col">

      <Header />

      <main className="flex-1 bg-gray-50">
        {children}
      </main>

      <Footer />

    </div>
  );
}
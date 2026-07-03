"use client";

export default function Home() {
  const handleLogin = () => {
    window.location.href = `${process.env.NEXT_PUBLIC_API_URL}/auth/google_oauth2`  
  };

  return (
    <main className="flex min-h-screen items-center justify-center">
      <button
        onClick={handleLogin}
        className="rounded-lg bg-black px-6 py-3 text-white"
      >
        Entrar com Google
      </button>
    </main>
  );
}
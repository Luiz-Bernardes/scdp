import { create } from "zustand";

type User = {
  id: number;
  name: string;
  email: string;
  role: string;
  team_ids: number[];
};

type AuthStore = {
  token: string | null;
  user: User | null;
  setAuth: (token: string, user: User) => void;
  logout: () => void;
};

export const useAuthStore = create<AuthStore>((set) => ({
  token: null,
  user: null,

  setAuth: (token, user) => {
    localStorage.setItem("token", token);

    set({
      token,
      user
    });
  },

  logout: () => {
    localStorage.removeItem("token");

    set({
      token: null,
      user: null
    });
  }
}));
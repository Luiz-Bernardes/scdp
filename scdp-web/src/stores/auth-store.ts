import { create } from "zustand";
import { User } from "@/types/user";

type AuthStore = {
  token: string |null;
  user: User | null;

  initialized: boolean;
  setAuth: (token: string, user: User) => void;
  logout: () => void;
  setInitialized: (value: boolean) => void;
};

export const useAuthStore = create<AuthStore>((set) => ({
  token: null,
  user: null,

  initialized: false,

  setAuth: (token, user) => {
    localStorage.setItem("token", token);

    set({
      token,
      user,
      initialized: true
    });
  },

  logout: () => {
    localStorage.removeItem("token");

    set({
      token: null,
      user: null,
      initialized: true
    });
  },

  setInitialized: (value) =>
    set({
      initialized: value
    })
}));
"use client";

import { createConsumer } from "@rails/actioncable";

export function createCable() {
  const token = localStorage.getItem("token");

  return createConsumer(
    `${process.env.NEXT_PUBLIC_API_WS_URL}/cable?token=${token}`
  );
}
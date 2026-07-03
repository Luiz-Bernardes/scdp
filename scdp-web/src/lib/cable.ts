import { createConsumer } from "@rails/actioncable";

export const cable = createConsumer(
  process.env.NEXT_PUBLIC_WS_URL
);
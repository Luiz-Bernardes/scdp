import {
  forwardRef,
  InputHTMLAttributes
} from "react";

type Props =
  InputHTMLAttributes<HTMLInputElement>;

export const Input =
  forwardRef<HTMLInputElement, Props>(
    function Input(
      {
        className = "",
        ...props
      },
      ref
    ) {

      return (

        <input
          ref={ref}
          className={`
            w-full
            rounded-lg
            border
            border-gray-300
            px-3
            py-2
            outline-none
            transition
            focus:border-blue-500
            focus:ring-2
            focus:ring-blue-200
            ${className}
          `}
          {...props}
        />

      );

    }
  );
import {
  forwardRef,
  SelectHTMLAttributes
} from "react";

type Props =
  SelectHTMLAttributes<HTMLSelectElement>;

export const Select =
  forwardRef<HTMLSelectElement, Props>(
    function Select(
      {
        className = "",
        children,
        ...props
      },
      ref
    ) {

      return (

        <select
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
        >
          {children}
        </select>

      );

    }
  );
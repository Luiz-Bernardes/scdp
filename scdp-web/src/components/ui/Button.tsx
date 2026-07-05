type Props = React.ButtonHTMLAttributes<HTMLButtonElement>;

export function Button({
  className = "",
  ...props
}: Props) {
  return (
    <button
      {...props}
      className={`
        rounded
        bg-blue-600
        px-4
        py-2
        text-white
        hover:bg-blue-700
        disabled:opacity-50
        ${className}
      `}
    />
  );
}
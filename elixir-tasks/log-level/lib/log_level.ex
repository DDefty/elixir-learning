defmodule LogLevel do
  def to_label(level, legacy?) do
    cond do
      level == 0 and legacy? == false -> :trace
      level == 1 -> :debug
      level == 2 -> :info
      level == 3 -> :warning
      level == 4 -> :error
      level == 5 and legacy? == false -> :fatal
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    check_alert = to_label(level, legacy?)
    cond do
      check_alert == :error or check_alert == :fatal -> :ops
      check_alert == :unknown and legacy? -> :dev1
      check_alert == :unknown -> :dev2
      true -> false
    end
  end
end

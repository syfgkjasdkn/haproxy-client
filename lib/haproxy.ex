defmodule HAProxy do
  @moduledoc File.read!("README.md")

  @spec connect(Path.t()) :: {:ok, :gen_tcp.socket()} | {:error, reason :: :inet.posix()}
  def connect(unix_socket_path) do
    :gen_tcp.connect({:local, unix_socket_path}, 0, [:binary, :local, active: false])
  end

  @spec query(:gen_tcp.socket(), String.t()) :: {:ok, String.t()} | {:error, any}
  @spec query(:gen_tcp.socket(), String.t(), pos_integer) :: {:ok, String.t()} | {:error, any}
  def query(socket, query, timeout \\ 1_000) do
    :ok = :gen_tcp.send(sock, <<"#{query}\n\r", 0>>)
    :gen_tcp.recv(sock, 0, timeout)
  end
end

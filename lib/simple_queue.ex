defmodule SimpleQueue do
  @moduledoc """
  Simple queue manager
  """

  use GenServer

  def start_link(initial_queue) when is_list(initial_queue) do
    GenServer.start_link(__MODULE__, initial_queue, name: __MODULE__)
  end

  def enqueue(item) do
    GenServer.cast(__MODULE__, {:enqueue, item})
  end

  def dequeue do
    GenServer.call(__MODULE__, :dequeue)
  end

  @impl true
  def init(initial_queue), do: {:ok, initial_queue}

  @impl true
  def handle_cast({:enqueue, item}, queue) do
    {:noreply, queue ++ [item]}
  end

  @impl true
  def handle_call(:dequeue, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:dequeue, _from, []) do
    {:reply, nil, []}
  end
end

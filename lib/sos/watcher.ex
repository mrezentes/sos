defmodule Sos.Watcher do
	use GenServer

	alias Sos.FileSystem

    # Client API

	def start_link(glob) do
	  GenServer.start_link(__MODULE__, %{glob: glob, last_map: %{}})
	end

	def check(watcher) do
	  GenServer.call(watcher, :check)
	end

	# Server API

	def handle_call(:check, _from, state = %{glob: glob, last_map: last_map}) do
		current_map = FileSystem.file_map(glob)
		changed = not Map.equal?(current_map, last_map)
		{:reply, changed, %{state | last_map: current_map}}
	end

end
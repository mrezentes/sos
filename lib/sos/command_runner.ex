defmodule Sos.CommandRunner do
	use GenServer

    # Client API

	# def start_link(task, arguments) do
	# 	spawn_link(__MODULE__, :run_task, [task, arguments])
	# end

	# def run_task(task, arguments \\ []) do
	# 	# test that this receives message run_task
	# 	receive do
	# 	  :execute_command ->
	# 		System.cmd(task, arguments)
	# 	end
	# end

	def start_link(task, arguments) do
	  GenServer.start_link(__MODULE__, %{task: task, arguments: arguments})
	end

	def run_command(command_runner) do
	  GenServer.call(command_runner, :execute_command)
	end

	# Server API

	def handle_call(:execute_command, _from, state = %{task: task, arguments: arguments}) do
		System.cmd(task, arguments)
		{:reply, :ok, state}
	end

end

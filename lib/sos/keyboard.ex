defmodule Keyboard do

	def wait_for_input do
		IO.getn("",1)
		|> handle_input
		wait_for_input
	end

	# handle messages - send message, call wait_for_input

	def handle_input("e"), do: IO.puts("got an e")
	def handle_input(command), do: IO.puts(command)

end
{:ok, watcher} = Sos.Watcher.start_link("*.txt")
{:ok, runner} = Sos.CommandRunner.start_link("touch", ["changed.log"])
Stream.repeatedly(fn ->
	Process.sleep(200)
	Sos.Watcher.check(watcher)
end)
|> Stream.filter(fn changed? -> changed? end)
|> Enum.each(fn _ -> Sos.CommandRunner.run_command(runner) end)

:timer.send_interval(200, self, :tick)
handle_info(:tick, state)
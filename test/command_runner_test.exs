defmodule CommandRunnerTest do
  use ExUnit.Case, async: true

  alias Sos.CommandRunner

  setup do
    dir = Path.relative_to_cwd("test/tmp_command_runner")
    File.mkdir!(dir)
    on_exit fn -> File.rm_rf!(dir) end

    %{dir: dir}
  end

  test "executes command", %{dir: dir} do
    file = Path.absname("changed.txt", dir)
    {:ok, command_runner} = CommandRunner.start_link("touch", [file])
    assert CommandRunner.run_command(command_runner) == :ok
    assert File.exists?(file)
  end

end
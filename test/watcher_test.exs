defmodule WatcherTest do
  use ExUnit.Case, async: true

  alias Sos.Watcher

  setup do
    dir = Path.relative_to_cwd("test/tmp")
    File.mkdir!(dir)
    on_exit fn -> File.rm_rf!(dir) end

    other_dir = Path.relative_to_cwd("test/other_tmp")
    File.mkdir!(other_dir)
    on_exit fn -> File.rm_rf!(other_dir) end

    %{dir: dir, other_dir: other_dir}
  end

  test "watcher will send first notification on startup" do
    glob = "*.exs"
    {:ok, watcher} = Watcher.start_link(glob)
    assert Watcher.check(watcher)
  end

  test "watcher will send notification if there are changes", %{dir: dir} do
  	Path.absname("changed.txt", dir) |> File.touch!
    glob = "#{dir}/*.txt"

    {:ok, watcher} = Watcher.start_link(glob)
    assert Watcher.check(watcher)

    Watcher.check(watcher)
    refute Watcher.check(watcher)

    Path.absname("new.txt", dir) |> File.touch!
    assert Watcher.check(watcher)
  end

  test "watcher will not send notification if changes are not in scope of the glob", %{dir: dir, other_dir: other_dir} do
    Path.absname("changed.txt", dir) |> File.touch!
    glob = "#{dir}/*.txt"

    {:ok, watcher} = Watcher.start_link(glob)
    assert Watcher.check(watcher)

    Path.absname("changed.txt", other_dir) |> File.touch!
    refute Watcher.check(watcher)
  end
end
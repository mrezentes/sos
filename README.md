# Sos

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `sos` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:sos, "~> 0.1.0"}]
    end
    ```

  2. Ensure `sos` is started before your application:

    ```elixir
    def application do
      [applications: [:sos]]
    end
    ```


    Process with watches, 1/sec/ for changes to kick off.
        - helper utility, function given a shell glob that returns a map of all the filenames: timestamp.
        - compare new maps to find changed files
        - if changed send message
    Message to another process to execute command.
    Process watch for keyboard commands - Messages to execute command.


    option to set timeframe, default to 1/sec
    dot file to hold rerun command(s) for a project

    Test for glob changed:
    first call should be true
    second call should be false
    create new file, get true
    create a file outside glob, return false

    Test for command runner:
    command with side effects, check side effects


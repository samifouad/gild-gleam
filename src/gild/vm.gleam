import gild/types.{type Config, type VM}
import gleam/int
import gleam/iterator
import gleam/json
import gleam/list
import gleam/string

// Function to create an empty configuration
pub fn new() -> Config {
  []
}

// Function to add an OS key-value pair to the configuration
pub fn os(config: Config, name: Result(String, String)) -> Config {
  case name {
    Ok(name) -> [#("gild_vm_os", name), ..config]
    Error(msg) -> [#("gild_vm_error", msg), ..config]
  }
}

// Function to add a name key-value pair to the configuration
pub fn name(config: Config, name: String) -> Config {
  [#("gild_vm_name", name), ..config]
}

// Function to add an OS key-value pair to the configuration
pub fn update(config: Config) -> Config {
  [#("gild_vm_update", "true"), ..config]
}

// Function to add an OS key-value pair to the configuration
pub fn install(config: Config, command: String) -> Config {
  let rand = int.to_string(int.random(100_000))

  case string.contains(does: command, contain: " ") {
    False -> [#("gild_vm_install_" <> rand, command), ..config]
    True -> list.concat([return_command_list(command), config])
  }
}

// return entire data struture
pub fn return(config: Config) -> VM {
  let vm_name = case list.key_find(config, "gild_vm_name") {
    Ok(name) -> "gild_vm_id-" <> name
    Error(_) -> "gild_vm_id-unknown"
  }
  #(vm_name, config)
}

// 
pub fn export(config: Config) -> String {
  let export_config = return(config)

  let json_export =
    json.object(
      iterator.from_list(export_config.1)
      |> iterator.map(fn(x) { #(x.0, json.string(x.1)) })
      |> iterator.to_list()
      |> list.reverse(),
    )
    |> json.to_string

  "{ \"gild_vm\": " <> json_export <> "}"
}

// local helper function to split string
// then transform each list item into a tuple
fn return_command_list(command: String) -> Config {
  let commands = list.unique(string.split(command, on: " "))

  iterator.from_list(commands)
  |> iterator.map(fn(x) {
    let rand = int.to_string(int.random(100_000))
    #("gild_vm_install_" <> rand, x)
  })
  |> iterator.to_list()
  |> list.reverse()
}

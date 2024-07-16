import gild/types.{type Cluster, type VM}
import gleam/io
import gleam/iterator
import gleam/json
import gleam/list
import gleam/result
import gleam/string
import gleam/string_builder.{type StringBuilder}

// import gleam/iterator.{from_list, map, to_list}
// import gleam/json.{object, string}

// Function to create an empty configuration
pub fn new() -> Cluster {
  [#("", [#("", "")])]
}

// Function to add a name key-value pair to the configuration
pub fn name(config: Cluster, name: String) -> Cluster {
  [#("gild_cluster-" <> name, [#("", "")]), ..config]
}

// Function to add a name key-value pair to the configuration
pub fn member(config: Cluster, member: VM) -> Cluster {
  [member, ..config]
}

pub fn export(config: Cluster) {
  let name: String = get_cluster_name(config)

  let nodes: Cluster = get_cluster_nodes(config)

  let members: StringBuilder = get_members(nodes)

  let return_start: String =
    "{ \"gild_cluster\": {"
    |> string.append(" \"meta\": {")
    |> string.append("\"name\": \"" <> name <> "\",")
    |> string.append("\"deploy_target\": \"self\"")
    |> string.append("}, \"members\": ")

  let return_end: String = "}}"

  let step1 = string_builder.prepend(members, return_start)
  let step2 = string_builder.append(step1, return_end)
  let step3 = string_builder.to_string(step2)

  io.debug(step3)
  //"{" <> export_config.0 <> ": " <> json_export <> "}"
  //"{ \"gild_vm\": " <> json_export <> "}"
}

// [
//   #("gild_vm_id-home", [#("gild_vm_install", "mysql_server"), #("gild_vm_install", "apache2"), #("gild_vm_update", "true"), #("gild_vm_os", "debian/bookworm"), #("gild_vm_name", "home")]), 
//   #("gild_vm_id-home", [#("gild_vm_install", "mysql_server"), #("gild_vm_update", "true"), #("gild_vm_os", "debian/bookworm"), #("gild_vm_name", "home")]),
//   #("cluster-from africa with love", [#("", "")]), #("", [#("", "")])
// ]

fn get_cluster_name(config: Cluster) -> String {
  let is_name =
    iterator.from_list(config)
    |> iterator.map(fn(x) {
      case x.0 {
        "gild_cluster-" <> name -> name
        _ -> "unknown"
      }
    })
    |> iterator.to_list
    |> list.unique
    |> list.pop(fn(x) { string.contains(does: x, contain: "unknown") })

  let name = result.unwrap(is_name, #("", ["gild-cluster"]))

  case name {
    #(_, [return_name]) -> return_name
    _ -> "gild-cluster"
  }
}

fn get_cluster_nodes(config: Cluster) -> Cluster {
  iterator.from_list(config)
  |> iterator.filter(fn(x) {
    let first_check = string.contains(does: x.0, contain: "gild_vm_id-")
    let second_check = string.contains(does: x.0, contain: "gild_container_id-")
    let both = #(first_check, second_check)

    let return = case both {
      #(True, False) -> True
      #(False, True) -> True
      _ -> False
    }

    return
  })
  |> iterator.to_list
}

fn get_members(nodes: Cluster) -> StringBuilder {
  let node_list =
    list.map(nodes, fn(x) {
      iterator.from_list(x.1)
      |> iterator.map(fn(y) { #(y.0, y.1) })
      |> iterator.to_list()
      |> list.reverse()
    })

  let sb_nodes =
    json.to_string_builder(
      json.array(node_list, of: fn(x) {
        json.object(
          iterator.from_list(x)
          |> iterator.map(fn(y) { #(y.0, json.string(y.1)) })
          |> iterator.to_list()
          |> list.reverse(),
        )
      }),
    )

  sb_nodes
}

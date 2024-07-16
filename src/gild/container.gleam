//import gild/os

pub type KV =
  #(String, String)

pub type Config =
  List(KV)

pub fn config() -> Config {
  []
}

pub fn image(config: Config, image: String) -> Config {
  [#("image", image), ..config]
}

pub fn name(config: Config, name: String) -> Config {
  [#("name", name), ..config]
}

pub fn version(config: Config, version: String) -> Config {
  [#("version", version), ..config]
}
// pub fn get_config_value(config: Config, key: String) -> Option(String) {
//   each(config, io.println)
// }

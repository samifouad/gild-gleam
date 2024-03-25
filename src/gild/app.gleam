pub type KV =
  #(String, String)

pub type Config =
  List(KV)

pub fn settings() -> Config {
  []
}

pub fn title(config: Config, title: String) -> Config {
  [#("title", title), ..config]
}

pub fn runtime(config: Config, runtime: String) -> Config {
  [#("runtime", runtime), ..config]
}
// pub fn get_config_value(config: Config, key: String) -> Option(String) {
//   each(config, io.println)
// }

pub type KV =
  #(String, String)

pub type Config =
  List(KV)

pub type VM =
  #(String, Config)

pub type Cluster =
  List(VM)

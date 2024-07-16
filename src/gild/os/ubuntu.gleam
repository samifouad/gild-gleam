pub type OS {
  Ubuntu(version: String)
  Debian(version: String)
  Arch(version: String)
  CentOS(version: String)
}

pub fn version(version: String) -> Result(#(String, String), String) {
  case version {
    "Noble" | "noble" | "24.04" -> Ok(#("ubuntu", "noble"))
    "Mantic" | "mantic" | "23.10" -> Ok(#("ubuntu", "mantic"))
    "Jammy" | "jammy" | "22.04" -> Ok(#("ubuntu", "jammy"))
    "Focal" | "focal" | "20.04" -> Ok(#("ubuntu", "focal"))
    "Bionic" | "bionic" | "18.04" -> Ok(#("ubuntu", "bionic"))
    _ -> Error("invalid ubuntu version selected")
  }
}
// pub fn return_os(os: String) -> String {
//   case os {
//     Ubuntu(_) -> "Ubuntu"
//     Debian(_) -> "Debian"
//     Arch(_) -> "Arch"
//     CentOS(_) -> "CentOS"
//   }
// }

// pub type Ubuntu {
//   NobleNumbat
//   ManticMinotaur
//   JammyJellyfish
// }

// pub type DebianVersion {
//   Bookworm
//   Bullseye
//   Buster
// }

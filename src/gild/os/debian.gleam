pub fn version(version: String) -> Result(String, String) {
  case version {
    "Bookworm" | "bookworm" | "12" -> Ok("debian/bookworm")
    "Bullseye" | "bullseye" | "11" -> Ok("debian/bullseye")
    "Buster" | "buster" | "10" -> Ok("debian/buster")
    _ -> Error("invalid debian version selected")
  }
}

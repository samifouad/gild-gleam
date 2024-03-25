import gild/app
import gild/react as r
import gleam/io

pub fn config() {
  app.settings()
  |> app.title("My React App")
}

pub fn main() {
  let jsx = r.jsx("<h1>Hello, name</h1>")

  io.debug(jsx)

  let element =
    r.create_element("div")
    |> r.prop(#("id", "container"))
    |> r.prop(#("className", "bg-white p-4"))
    |> r.children(jsx)

  r.render(element)
}

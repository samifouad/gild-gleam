import gild/app
import gild/react as r

pub fn config() {
  app.settings()
  |> app.title("My React App")
}

pub fn main() {
  let element =
    r.create_element("div")
    |> r.prop(#("id", "container"))
    |> r.prop(#("className", "bg-white p-4"))
    |> r.children("hello world!")

  r.render(element)
}

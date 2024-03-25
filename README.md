# gild_frontend

work in progress

extremely alpha

feedback welcome!

example usage:
```import gild/app
import gild/react as r
import gleam/io

pub fn config() {
  app.settings()
  |> app.title("My React App")
}

pub fn main() {
  let element =
    r.create_element("div")
    |> r.prop(#("id", "container"))
    |> r.prop(#("className", "bg-white p-4"))
    |> r.children(jsx)

  io.debug(r.render(element))
}
```

output:
```#("div", [#("className", "bg-white p-4"), #("id", "container")], "hello world!")
```

after removing the debug print, you can run `gleam build --target javascript` and see the `index.html` file for how it's used

run `npx serve` and check out the results
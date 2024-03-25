pub type Element =
  #(String, Props, String)

pub type Prop =
  #(String, String)

pub type Props =
  List(Prop)

pub fn create_element(tag: String) -> Element {
  let props: Props = []
  let element: Element = #(tag, props, "")

  element
  // for now, there is no filter, so people can create any element
  // need to figure out a more elegant way to avoid overwriting
  // existing dom elements and completely avoiding using some, eg. <marquee>
  // 
  // when implemented: will have to change return to Result(Element, String)
  //
  // let valid_element = ["html", "body", "div", "span", "p"]
  // case list.contains(valid_element, tag) {
  //   True -> {
  //     let element: Element = #(tag, props, children)
  //     Ok(element)
  //   }
  //   False -> Error("error")
  // }
}

pub fn prop(element: Element, prop: #(String, String)) -> Element {
  let #(tag, mut_props, children) = element
  let updated_props = [prop, ..mut_props]
  #(tag, updated_props, children)
}

pub fn children(element: Element, children: String) -> Element {
  let #(tag, props, _) = element
  #(tag, props, children)
}

pub fn render(element: Element) -> Element {
  element
}

pub fn jsx(markup: String) {
  markup
}

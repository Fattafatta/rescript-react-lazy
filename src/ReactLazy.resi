module type Component = {
  module type T
}

type dynamicImport

@val
external import_: string => Js.Promise.t<dynamicImport> = "import"

module MakeLazy: (Item: Component) =>
{
  let make: (unit => Js.Promise.t<dynamicImport>, 'makeProps) => module(Item.T)
}

module NoProps: {
  module Component: {
    module type T = {
      let make: React.component<unit>
      let makeProps: (~key: string=?, unit) => unit
    }
  }

  let make: (unit => Js.Promise.t<dynamicImport>) => module(Component.T)
}

module Suspense: {
  let makeProps: (
    ~fallback: React.element,
    ~children: React.element,
    ~key: string=?,
    unit,
  ) => {"children": React.element, "fallback": React.element}
  let make: React.componentLike<
    {"children": React.element, "fallback": React.element},
    React.element,
  >
}

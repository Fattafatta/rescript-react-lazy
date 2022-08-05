module type Component = {
  module type T
}

type dynamicImport

@val
external import_: string => Js.Promise.t<dynamicImport> = "import"

module MakeLazy = (Item: Component) => {
  type lazyMake

  @module("react")
  external lazy_: (unit => Js.Promise.t<lazyMake>) => lazyMake = "lazy"

  external _makeModule: 'comp => module(Item.T) = "%identity"

  let _addDefault: dynamicImport => option<lazyMake> = %raw(`
    function(comp) {
      return comp.make ? {"default": comp.make} : undefined
    }
  `)

  exception ImportError(string)

  let make = (func, makeProps) => {
    let l = lazy_(() => func()->Js.Promise.then_(comp => {
        switch _addDefault(comp) {
        | Some(m) => Js.Promise.resolve(m)
        | _ => Js.Promise.reject(ImportError("Loaded module is not a component"))
        }
      }, _))
    _makeModule({"make": l, "makeProps": makeProps})
  }
}

// component without props
module NoProps = {
  module Component = {
    module type T = {
      let make: React.component<unit>
      let makeProps: (~key: string=?, unit) => unit
    }
  }
  module L = MakeLazy(Component)

  let make = L.make(_, () => ())
}

module Suspense = {
  @module("react") @react.component
  external make: (~fallback: React.element, ~children: React.element, unit) => React.element =
    "Suspense"
}

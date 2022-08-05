@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  module LazyCounter = {
    module type T = module type of Counter
  }

  module Lazy = ReactLazy.MakeLazy(LazyCounter)

  let module(CountComp) = Lazy.make(() => ReactLazy.import_("./Counter.bs.js"), Counter.makeProps)

  switch url.path {
  | list{"counter"} =>
    <ReactLazy.Suspense fallback={"loading..."->React.string}> <CountComp /> </ReactLazy.Suspense>
  | _ => <Home />
  }
}

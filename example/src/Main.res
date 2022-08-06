module Root = {
  type t

  @send external render: (t, React.element) => unit = "render"

  @send external unmount: (t, unit) => unit = "unmount"
}

@module("react-dom/client")
external createRoot: Dom.element => Root.t = "createRoot"

let root = ReactDOM.querySelector("#root")->Belt.Option.getExn->createRoot

Root.render(root, <React.StrictMode> <App /> </React.StrictMode>)

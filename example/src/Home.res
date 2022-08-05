@react.component
let make = () => {
  <div>
  <h1>{"Home"->React.string}</h1>
  <button onClick={_ => RescriptReactRouter.push("counter")}>{"Go to counter"->React.string}</button>
  </div>
}
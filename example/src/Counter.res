@react.component
let make = (~initial=0) => {
  let (count, setCount) = React.useState(() => initial)
  <p>
    <button onClick={_e => setCount(count => count + 1)}>
      {`count is: ${count->Belt.Int.toString}`->React.string}
    </button>
  </p>
}

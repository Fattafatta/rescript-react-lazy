# rescript-react-lazy

Minimal bindings to use `React.lazy` with ResScript.

## Installation

Install with `npm`:

```bash
npm install @fattafatta/rescript-react-lazy
```

Or install with `yarn`:

```bash
yarn add @fattafatta/rescript-react-lazy
```

Add `@fattafatta/rescript-react-lazy` as a dependency to your `bsconfig.json`:

```json
"bs-dependencies": ["@rescript/react", "@fattafatta/rescript-react-lazy"]
```

## Usage

Check out the `example` folder for a fully working example.

### Components without props

First create a Component to import in a separate file (e.g. `Component.res`). 

This will lazy-load the component:
```rescript
module App = {
  @react.component
  let make = () => {
    let module(Comp) = ReactLazy.NoProps.make(() => ReactLazy.import_("./Component.bs"))
    <Comp /> 
  }
}
```

### Component with props

First create a Component with props to import in a separate file (e.g. `Component.res`). 
We use a Functor to set the type of the imported component.

```rescript
// define type
module C = {
  module type T = module type of Component
}

// create Functor
module Laz = ReactLazy.MakeLazy(C)

// lazy-load component
module Comp = unpack(Laz.make(() => ReactLazy.import_("./Component.bs"), Component.makeProps))

module App = {
  @react.component
  let make = () => {
    <Comp text="Hello World!" /> 
  }
}
```


## Notes

The code generated with these bindings is not completely type safe. It is easily possible to set the wrong type of a component, by for example creating a Functor with `Component1.res` but importing `./Component2.bs`. There is no way for the compiler to warn about this. So always make sure to import the right component.

There is an open discussion about dynamic imports on the ReScript forum that might solve this: [Discussion](https://forum.rescript-lang.org/t/rfc-dynamic-imports-in-rescript/3605).

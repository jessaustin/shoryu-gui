{h, makeDOMDriver, run} = require 'cyclejs'

run (drivers) ->
  DOM:
    drivers.DOM.get '.myinput', 'input'
      .map (ev) -> ev.target.value
      .startWith ''
      .map (name) ->
        h 'div', [
          h 'label', 'Name:'
          h 'input.myinput', attributes: type: 'text'
          h 'hr'
          h 'h1', 'Yo ' + name
        ]
, DOM: makeDOMDriver '#container'

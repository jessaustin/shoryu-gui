{run, Rx} = require '@cycle/core'
{h, makeDOMDriver} = require '@cycle/web'

name = (given, family, eastern) ->
#  console.log [given, family, eastern]
  g = h 'div', key: 0, [
    h 'label', 'Given Name: '
    h 'input.given', attributes:
      type: 'text'
      placeholder: 'given name'
      value: given
  ]
  f = h 'div', key: 1, [
    h 'label', 'Family Name: '
    h 'input.family', attributes:
      type: 'text'
      placeholder: 'family name'
      value: family
  ]
  e = h 'div', [
    h 'label', 'eastern order? '
    h 'input.eastern', attributes:
      type: 'checkbox'
      value: eastern
  ]
  unless eastern
    h 'div', [g, f, e]
  else
    h 'div', [f, g, e]

run (drivers) ->
  given$ = drivers.DOM.get '.given', 'input'
    .map (ev) -> ev.target.value
    .startWith ''
  family$ = drivers.DOM.get '.family', 'input'
    .map (ev) -> ev.target.value
    .startWith ''
  eastern$ = drivers.DOM.get '.eastern', 'change'
    .map (ev) -> ev.target.checked
    .startWith no
  DOM: Rx.Observable.combineLatest given$, family$, eastern$, name
, DOM: makeDOMDriver '#container'

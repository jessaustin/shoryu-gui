{run, Rx} = require '@cycle/core'
{h, makeDOMDriver} = require '@cycle/web'

name = (given, family, eastern, label='0') ->
  g = h '.form-group', key: 0, [
    h 'label.control-label.col-xs-2', attributes: for: "given-#{label}", 'Given Name:'
    h '.col-xs-3', [
      h "input#given-#{label}.form-control", attributes:
        type: 'text'
        placeholder: 'given name'
        value: given
    ]
  ]
  f = h '.form-group', key: 1, [
    h 'label.control-label.col-xs-2', attributes: for: "family-#{label}", 'Family Name:'
    h '.col-xs-3', [
      h "input#family-#{label}.form-control", attributes:
        type: 'text'
        placeholder: 'family name'
        value: family
    ]
  ]
  e = h '.form-group', [
    h 'label.checkbox-inline.col-xs-offset-2', [
      h "input#eastern-#{label}", attributes:
        type: 'checkbox'
        value: eastern
      'eastern name order?'
    ]
  ]
  unless eastern
    h 'form.form-horizontal', [g, f, e]
  else
    h 'form.form-horizontal', [f, g, e]

run (drivers) ->
  given$ = drivers.DOM.get '#given-0', 'input'
    .map (ev) -> ev.target.value
    .startWith ''
  family$ = drivers.DOM.get '#family-0', 'input'
    .map (ev) -> ev.target.value
    .startWith ''
  eastern$ = drivers.DOM.get '#eastern-0', 'change'
    .map (ev) -> ev.target.checked
    .startWith no
  DOM: Rx.Observable.combineLatest given$, family$, eastern$, name
, DOM: makeDOMDriver '.container-fluid'

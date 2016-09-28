{createElement, createClass, createFactory, DOM} = require 'react'
{render} = require 'react-dom'
{div, p} = DOM
TierListComponent = createFactory require './tier-list'

RootComponent = createClass
  render: ->
      div
        id: "root"
        TierListComponent null

module.exports = RootComponent

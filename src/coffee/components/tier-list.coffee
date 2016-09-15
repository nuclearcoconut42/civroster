{createElement, createClass, DOM} = require 'react'
{render} = require 'react-dom'
{div, form, input, button, li, ol, option, select} = DOM

TierListComponent = createClass
  getInitialState: ->
    list: localStorage.getItem('civroster') || []
    tier: ''
    civ: ''
  onTierChange: (e) ->
    this.setState {tier: e.target.value}
  onCivChange: (e) ->
    this.setState {civ: e.target.value}
  onSubmit: (e) ->
    e.preventDefault()
    if this.state.tier.isNaN
      return
    if 0 <= this.state.tier < this.state.list.length
      nextList = this.state.list
      nextList[this.state.tier].push this.state.civ
    else
      nextList = this.state.list
      nextList.push [this.state.civ]
    nextTier = ''
    nextCiv = ''
  render: ->
    createCiv = (civ) ->
      li null, civ
    createTier = (tier) ->
      ol null, tier.map createCiv
    return(
      div
        id: "tier-list"
        div
          id: "form"
          form
            onSubmit: this.onSubmit
            input
              id: "tier-input"
              onChange: this.onTierChange
              value: this.state.tier
            select
              name: "civ"
              onChange: this.onCivChange
              value: this.state.civ
              option
                value: "America"
                "America"
              option
                value: "Arabia"
                "Arabia"
              option
                value: "Assyria"
                "Assyria"
              option
                value: "Austria"
                "Austria"
              option
                value: "Aztecs"
                "Aztecs"
              option
                value: "Babylon"
                "Babylon"
              option
                value: "Brazil"
                "Brazil"
              option
                value: "Byzantium"
                "Byzantium"
              option
                value: "Carthage"
                "Carthage"
              option
                value: "Celts"
                "Celts"
              option
                value: "China"
                "China"
              option
                value: "Denmark"
                "Denmark"
              option
                value: "Egypt"
                "Egypt"
              option
                value: "England"
                "England"
              option
                value: "Ethiopia"
                "Ethiopia"
              option
                value: "France"
                "France"
              option
                value: "Germany"
                "Germany"
              option
                value: "Greece"
                "Greece"
              option
                value: "Huns"
                "Huns"
              option
                value: "Inca"
                "Inca"
              option
                value: "India"
                "India"
              option
                value: "Indonesia"
                "Indonesia"
              option
                value: "Iriquois"
                "Iriquois"
              option
                value: "Japan"
                "Japan"
              option
                value: "Korea"
                "Korea"
              option
                value: "Maya"
                "Maya"
              option
                value: "Mongolia"
                "Mongolia"
              option
                value: "Morocco"
                "Morocco"
              option
                value: "Netherlands"
                "Netherlands"
              option
                value: "Ottomans"
                "Ottomans"
              option
                value: "Persia"
                "Persia"
              option
                value: "Poland"
                "Poland"
              option
                value: "Polynesia"
                "Polynesia"
              option
                value: "Portugal"
                "Portugal"
              option
                value: "Rome"
                "Rome"
              option
                value: "Russia"
                "Russia"
              option
                value: "Shoshone"
                "Shoshone"
              option
                value: "Siam"
                "Siam"
              option
                value: "Songhai"
                "Songhai"
              option
                value: "Spain"
                "Spain"
              option
                value: "Sweden"
                "Sweden"
              option
                value: "Venice"
                "Venice"
              option
                value: "Zulus"
                "Zulus"
            button
              type: "submit"
              "Submit to tier " + this.state.tier
        div
          id: "list"
          ol null,
            this.state.list.map createTier
    )

module.exports = TierListComponent

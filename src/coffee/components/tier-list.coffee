{createElement, createClass, DOM} = require 'react'
{render} = require 'react-dom'
{div, form, input, button, li, ol, ul, option, select} = DOM

TierListComponent = createClass
  onSave: ->
    localStorage.setItem 'civroster', this.state.list
  onClear: ->
    localStorage.setItem 'civroster', []
  getInitialState: ->
    list: localStorage.getItem('civroster') || []
    tier: '0'
    civ: 'America'
    roster: []
  onTierChange: (e) ->
    if !e.target.value.isNaN || !e.target.value
      this.setState
        tier: e.target.value
  onCivChange: (e) ->
    this.setState
      civ: e.target.value
  onSubmit: (e) ->
    e.preventDefault()
    if this.state.tier.isNaN || !this.state.tier
      return
    if this.state.tier < this.state.list.length && this.state.tier >= 0
      nextList = this.state.list
      nextList[this.state.tier].push this.state.civ
    else
      nextList = this.state.list
      nextList.push [this.state.civ]
    this.setState(
      list: nextList
      )
  createCiv: (tier, index) ->
    li
      key: index
      tier[index]
  createTier: (index) ->
    a = []
    i = 0
    while i < this.state.list[index].length
      a.push this.createCiv this.state.list[index], i
      i++
    return li
      key: index
      ul null, a
  createList: ->
    a = []
    i = 0
    while i < this.state.list.length
      a.push this.createTier i
      i++
    return a
  onGenerate: (e) ->
    nextRoster = []
    i = 0
    tier = []
    while i < this.state.list.length
      tier = this.state.list[i + Math.floor(Math.random() * 2)] || this.state.list[i]
      nextRoster.push tier[Math.floor(Math.random() * tier.length)]
      i+=2
    this.setState
      roster: nextRoster
  createRoster: ->
    a = []
    i = 0
    while i < this.state.roster.length
      a.push this.createCiv this.state.roster, i
      i++
    return ul null, a
  render: ->
    return(
      div
        id: "tier-list"
        div
          id: "form"
          form
            onSubmit: this.onSubmit
            input
              id: "tier-input"
              type: "number"
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
          ol
            start: "0"
            this.createList()
        button
          id: "save"
          onClick: this.onSave
          "Save tier list to local storage"
        button
          id: "clear"
          onClick: this.onClear
          "Remove tier list from local storage"
        button
          id: "generate"
          onClick: this.onGenerate
          "Generate Roster"
        this.createRoster()
    )

module.exports = TierListComponent

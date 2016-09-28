{createElement, createClass, createFactory, DOM} = require 'react'
{render} = require 'react-dom'
{div, form, input, button, li, ol, ul, option, select} = DOM
copy = createFactory require 'react-copy-to-clipboard'

TierListComponent = createClass
  onSave: ->
    localStorage.setItem 'civroster', JSON.stringify this.state.list
  onClear: ->
    localStorage.setItem 'civroster', []
  queryLocalStorage: ->
    if localStorage.getItem 'civroster'
      return JSON.parse localStorage.getItem 'civroster'
    return []
  getInitialState: ->
    list: this.queryLocalStorage()
    tier: '0'
    civ: 'America'
    roster: []
    paste: ''
    guarantee: 2
    sum: 10
    quantity: 3
    available: null
  onPasteChange: (e) ->
    this.setState
      paste: e.target.value
  onPasteSubmit: (e) ->
    e.preventDefault()
    this.setState
      list: JSON.parse(this.state.paste)
  onTierChange: (e) ->
    if !e.target.value.isNaN || !e.target.value
      this.setState
        tier: e.target.value
  onCivChange: (e) ->
    this.setState
      civ: e.target.value
  onGuaranteeChange: (e) ->
    this.setState
      guarantee: e.target.value
  onQuantityChange: (e) ->
    this.setState
      quantity: e.target.value
  onSumChange: (e) ->
    this.setState
      sum: e.target.value
  onSubmit: (e) ->
    e.preventDefault()
    if this.state.tier.isNaN || !this.state.tier
      return
    if this.state.tier < this.state.list.length && this.state.tier >= 0
      nextList = JSON.parse JSON.stringify this.state.list
      nextList[this.state.tier].push this.state.civ
    else
      nextList = JSON.parse JSON.stringify this.state.list
      nextList.push [this.state.civ]
    this.setState
      list: nextList
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
    console.log this.state.list
    a = []
    i = 0
    while i < this.state.list.length
      a.push this.createTier i
      i++
    return a
  onGenerate: (e) ->
    e.preventDefault()
    if this.state.available != null
      available = JSON.parse JSON.stringify this.state.available
    else
      available = JSON.parse JSON.stringify this.state.list
    currentRoster = JSON.parse JSON.stringify this.state.roster
    nextRoster = []
    tiers = []
    generateSet = (u, l, s, q, availableTiers, available) ->
      console.log available
      if !availableTiers && available != null
        console.log 'executing'
        availableTiers = []
        for availableTier in available
          if availableTier != 0
            availableTiers.push availableTier.length
      console.log 'availableTiers: ' + availableTiers
      tier = 0
      console.log 's: ' + s + ', u: ' + u + ', l: ' + l
      if q == 1 && availableTiers[s] != 0
        tiers.push s
        return
      else
        return 'retry'
      if s > u + l
        console.log 'isUpper'
        picks = []
        i = s - u * (q - 1)
        while i < u + 1
          if availableTiers[i] != 0
            picks.push i
          i++
      else
        console.log 'isLower'
        picks = []
        i = l
        while i < s - l * (q - 1) + 1
          if availableTiers[i] != 0
            picks.push i
          i++
      console.log 'picks: ' + picks
      if picks == []
        return 'retry'
      tier = picks[Math.floor(picks.length *  Math.random())]
      console.log 'tier: ' + tier 
      tiers.push tier
      availableTiers[tier]--
      while generateSet(u, l, s - tier, q - 1, availableTiers, available) == 'retry' || availableTiers[tier] == 0
        tiers.pull
        generateSet u, l, s, q, availableTiers, available 
    console.log tiers
    if generateSet(this.state.list.length - 1, 0, this.state.sum, this.state.quantity, null, available) != 'retry'
      for tier in tiers
        a = Math.floor Math.random() * available[tier].length
        nextRoster.push available[tier][a]
        available[tier].splice a, 1
    i = Math.floor available[this.state.guarantee].length * Math.random()
    nextRoster.push available[this.state.guarantee][i]
    available.splice i, 1
    currentRoster.push nextRoster
    this.setState
      available: available
      roster: currentRoster
  createRoster: ->
    a = []
    i = 0
    while i < this.state.roster.length
      b = []
      j = 0
      while j < this.state.roster[i].length
        b.push this.createCiv this.state.roster[i], j
        j++
      a.push li
        key: i
        ul null, b
      i++
    return ol null, a
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
        copy
          text: JSON.stringify this.state.list
          button null,
            "Copy to clipboard"
        div
          id: "paste-form"
          form
            onSubmit: this.onPasteSubmit
            input
              type: "text"
              value: this.state.paste
              onChange: this.onPasteChange
            button
              type: "submit"
              "Submit tier list (Use JSON)"
        div
          id: "generate-form"
          form
            onSubmit: this.onGenerate
            input
              type: "number"
              value: this.state.guarantee
              onChange: this.onGuaranteeChange
            input
              type: "number"
              value: this.state.quantity
              onChange: this.onQuantityChange
            input
              type: "number"
              value: this.state.sum
              onChange: this.onSumChange
            button null,
              "Generate Roster"
        this.createRoster()
    )

module.exports = TierListComponent

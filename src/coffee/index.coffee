# The base element of your app. Can be a router if you like.
{createElement} = require 'react'
{render} = require 'react-dom'
require '../sass/style.sass'
root = require './components/root'

render createElement(root), document.getElementById 'app'

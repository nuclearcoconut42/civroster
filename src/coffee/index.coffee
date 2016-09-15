# The base element of your app. Can be a router if you like.
{createElement} = require 'react'
{render} = require 'react-dom'
root = require './components/root'

render root, document.getElementById 'app'

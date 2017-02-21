chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'hubot-geocode', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/hubot-geocode')(@robot)

  it 'registers a respond listener', ->
    expect(@robot.respond).to.have.been.calledWith(/geocode( me)? (.*)/i)

  it 'registers a hear listener', ->
    expect(@robot.hear).to.have.been.calledWith(/where is (.*)/i)

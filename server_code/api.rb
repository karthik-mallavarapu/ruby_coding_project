#!/usr/bin/env ruby

require 'sinatra/base'
require 'sinatra/activerecord'
require 'json'
require 'pry'

Dir.glob('models/*.rb').each { |r| load r}

class FleetManager < Sinatra::Base
  configure do
    set :bind, '0.0.0.0'
    set :environment, 'development'
  end

  before do
    content_type 'application/json'
  end

  post '/enroll' do
    params = JSON.parse(request.body.read)
    customer = Customer.find_by(enrollment_secret: params['enroll_secret'])
    return invalid_enrollment_response if customer.nil?
    node = customer.nodes.find_by(host_identifier: params['host_identifier'])
    return invalid_enrollment_response if node.nil?
    valid_enrollment_response(node.key)
  end

  post '/configuration' do
    params = JSON.parse(request.body.read)
    node = Node.find_by(key: params['node_key'])
    return invalid_config_response if node.nil?
    node.configuration
  end

  private

  def invalid_enrollment_response
    {
      node_key: '',
      node_invalid: true
    }.to_json
  end

  def valid_enrollment_response(node_key)
    {
      node_key: node_key,
      node_invalid: false
    }.to_json
  end

  def invalid_config_response
    { node_invalid: true }.to_json
  end
end

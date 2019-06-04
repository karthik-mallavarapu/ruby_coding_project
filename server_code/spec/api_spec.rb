require_relative './spec_helper.rb'
require_relative '../api.rb'

RSpec.describe FleetManager do
  let(:sample_config) { { 'test' => true, 'query' => 'sample' } }
  before { setup_database }

  describe 'POST /enroll' do
    it 'should enroll customer node with secret and host identifier' do
      post '/enroll', { enroll_secret: 'secret', host_identifier: 'identifier' }.to_json, { 'Content-Type': 'application/json' }
      expect(parsed_response).to eq({ 'node_key' => 'key', 'node_invalid' => false })
    end

    it 'should return invalid response when customer secret is not found' do
      post '/enroll', { enroll_secret: 'invalid_secret', host_identifier: 'identifier' }.to_json, { 'Content-Type': 'application/json' }
      expect(parsed_response).to eq({ 'node_key' => '', 'node_invalid' => true })
    end

    it 'should return invalid response when node host identifier is not found' do
      post '/enroll', { enroll_secret: 'secret', host_identifier: 'invalid_identifier' }.to_json, { 'Content-Type': 'application/json' }
      expect(parsed_response).to eq({ 'node_key' => '', 'node_invalid' => true })
    end
  end

  describe 'POST /configuration' do
    it 'should return configuration for a node with the right node key' do
      post '/configuration', { node_key: 'key' }.to_json, { 'Content-Type': 'application/json' }
      expect(parsed_response).to eq(sample_config)
    end

    it 'should return invalid response when the node key is not found' do
      post '/configuration', { node_key: 'invalid_key' }.to_json, { 'Content-Type': 'application/json' }
      expect(parsed_response).to eq({ 'node_invalid' => true })
    end
  end
end

def parsed_response
  JSON.parse(last_response.body)
end

def setup_database
  Customer.destroy_all
  customer = Customer.create!(name: 'test', enrollment_secret: 'secret')
  customer.nodes.create!(host_identifier: 'identifier', key: 'key', configuration: sample_config.to_json)
end

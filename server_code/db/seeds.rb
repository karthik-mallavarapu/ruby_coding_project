# Create seed data
# Load models
Dir.glob('app/models/*.rb').each { |r| load r}

sample_config = {
  "tls_plugin": {
    "tls_plugin": {
      "schedule": {
        "test_query": {
          "interval":"5","description":"test query","query":"SELECT * FROM processes;"
        }
      }
    }
  }
}

host_identifiers = [
  '312bf002-e519-45e6-98a7-8aac504b59e5',
  'e352d92d-db24-4cee-830d-9e4a24f38507',
  'b5c8239c-6681-4d05-9b42-e02df4bd5017',
  '6bdc6d99-3950-49ea-8403-25828a65ea4a',
  '8D10F495-519A-5381-9FAD-0B8AA9DFE3D2'
]

puts 'Setting up the database with seed data...'

5.times do |i|
  customer = Customer.create!(name: "customer_#{i}", enrollment_secret: "secret_#{i}")
  customer.nodes.create!(key: "node_key_#{i}", host_identifier: host_identifiers[i], configuration: sample_config.to_json)
end

puts 'Seed data has been created!!'

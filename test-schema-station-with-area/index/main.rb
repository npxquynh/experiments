# /usr/bin/ruby
require 'pry'
require 'json'
require 'jsonapi/parser'
require 'json-schema'

SCHEMA_PATH = './station_schema_knut.json'
STATION_FILES = [
  './station_many.json',
  # './station_with_area.json',
  # './station_without_area.json'
]

WRONG_STATION_FILES = [
  './wrong_station.json'
]
schema = JSON.parse(File.read(SCHEMA_PATH))

begin
  STATION_FILES.each do |station_file|
    station = JSON.parse(File.read(station_file))
    puts JSON::Validator.fully_validate(schema, station)
    # puts JSON::Validator.fully_validate(schema, station, strict: true)
  end

  puts "---------"
  puts "ERRORS"
  WRONG_STATION_FILES.each do |station_file|
    station = JSON.parse(File.read(station_file))
    puts JSON::Validator.fully_validate(schema, station, strict: true)
  end
rescue JSON::Schema::ValidationError => e
  e.message
end

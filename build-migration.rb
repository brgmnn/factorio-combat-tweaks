#!/usr/bin/env ruby

require 'json'
require 'jbuilder'

# @rampant_variants = 1
@end_tier = 10
@tiers = {
  1 => 'larva',
  2 => 'pupae',
  3 => 'worker',
  4 => 'grunt',
  5 => 'soldier',
  6 => 'elite',
  7 => 'champion',
  8 => 'overlord',
  9 => 'titan',
  10 => 'leviathan'
}
@factions = {
  # real mappings
  'neutral' => 'common',
  'fast' => 'fast',

  # replacement mappings for now
  'acid' => 'common',
  'electric' => 'common',
  'energy-thief' => 'common',
  'fire' => 'fast',
  'inferno' => 'fast',
  'laser' => 'common',
  'nuclear' => 'common',
  'physical' => 'fast',
  'poison' => 'common',
  'spawner' => 'common',
  'suicide' => 'fast',
  'troll' => 'fast',
  'wasp' => 'common'
}


rampant_migration = Jbuilder.encode do |m|
  m.entity do |json|

    @factions.each do |r_faction, ct_faction|
      # Biters
      for tier in 1..@end_tier do
        json.child! { |c| c.array! ["#{r_faction}-biter-v1-t#{tier}-rampant", "#{ct_faction}-#{@tiers[tier]}-biter"] }
      end

      # Spitters
      for tier in 1..@end_tier do
        json.child! { |c| c.array! ["#{r_faction}-spitter-v1-t#{tier}-rampant", "#{ct_faction}-#{@tiers[tier]}-spitter"] }
      end

      # Worms
      for tier in 1..@end_tier do
        json.child! { |c| c.array! ["#{r_faction}-worm-v1-t#{tier}-rampant", "#{ct_faction}-#{@tiers[tier]}-worm-turret"] }
      end

      # Biter spawner
      for tier in 1..@end_tier do
        json.child! { |c| c.array! ["#{r_faction}-biter-spawner-v1-t#{tier}-rampant", "#{ct_faction}-biter-spawner"] }
      end

      # Spitter spawner
      for tier in 1..@end_tier do
        json.child! { |c| c.array! ["#{r_faction}-spitter-spawner-v1-t#{tier}-rampant", "#{ct_faction}-spitter-spawner"] }
      end
    end

  end
end

puts rampant_migration
# # Writes the file
# File.open('./migrations/rampant.json', 'w') do |file|
#   file.write(rampant_migration)
# end

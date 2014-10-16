# This function returns the name of a country for an ISO3166-1 alpha-3 code.
# If you pass a valid country name, it will just return that instead.
# The look up is case-insensitive.
#
# ~18x improvement available

require_relative '_country_codes'

module Locale
  module_function

  def country_name(lookup)
    matches = COUNTRY_CODE_MAP.select do |code, country|
      [code.downcase, country.downcase].include? lookup.downcase
    end
    matches.first.last if matches.any?
  end

end

100.times { Locale.country_name 'denmark' }

# Examples
{
  'NZL'         => 'New Zealand',
  'nzl'         => 'New Zealand',
  'New Zealand' => 'New Zealand',
  'new zealand' => 'New Zealand',
  'foo'         => nil,
}

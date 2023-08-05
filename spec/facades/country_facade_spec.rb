require 'rails_helper'

describe CountryFacade do
  describe '.get_country' do
    context 'when country is nil' do
      it 'returns a random country name', :vcr do
        allow(CountryService).to receive(:all_countries).and_return([ { name: { common: 'United States' } }, { name: { common: 'France' } } ])

        result = CountryFacade.get_country(nil)

        expect(['United States', 'France']).to include(result)
      end
    end

    context 'when country is not nil' do
      it 'returns the given country name', :vcr do
        result = CountryFacade.get_country('Spain')

        expect(result).to eq('Spain')
      end
    end
  end
end
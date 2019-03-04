require 'rails_helper'

describe HotelsController do
  let!(:hotels) { [create(:hotel), create(:hotel)] }

  describe '#index' do
    before { get hotels_path }

    let(:expected_result) do
      HotelSerializer.new(hotels).serialized_json
    end

    it 'return the list of hotels' do
      expect(response).to be_successful

      expect(json['data'].size).to eq(hotels.size)
      expect(response.body).to eq expected_result
    end
  end

  describe '#show' do
    before { get hotel_path(hotels.first) }

    let(:expected_result) do
      HotelSerializer.new(hotels.first).serialized_json
    end

    it 'returns serialized hotel json' do
      expect(response).to be_successful
      expect(response.body).to eq expected_result
    end
  end
end

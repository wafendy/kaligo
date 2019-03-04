require 'rails_helper'

describe Hotel do
  context 'scopes' do
    let!(:hotel_1) { create(:hotel, id: 'xTx', destination_id: 1881) }
    let!(:hotel_2) { create(:hotel, id: 'TxT', destination_id: 1771) }
    let!(:hotel_3) { create(:hotel, id: 'aBa', destination_id: 1881) }
    let!(:hotel_4) { create(:hotel, id: 'cDc', destination_id: 1661) }

    describe '#for_hotels' do
      subject { Hotel.for_hotels(['TxT', 'cDc']) }

      it { is_expected.to match_array [hotel_2, hotel_4] }
    end

    describe '#for_destination' do
      subject { Hotel.for_destination(1881) }

      it { is_expected.to match_array [hotel_1, hotel_3] }
    end
  end

  context 'helpers' do
    describe '#self.sanitize_amenities_general' do
    end
    describe '#self.sanitize_amenities_room' do
    end
  end
end

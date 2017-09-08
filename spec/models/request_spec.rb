require 'rails_helper'

describe Request do
  subject { Request.new }

  describe 'validations' do
    it 'invalid without client' do
      expect(subject).to be_invalid
      expect(subject.errors[:client]).not_to be_empty
    end

    it 'valid without agent' do
      expect(subject).to be_invalid
      expect(subject.errors[:agent]).to be_empty
    end

    it 'invalid without subject' do
      expect(subject).to be_invalid
      expect(subject.errors[:subject]).not_to be_empty
    end
  end

  describe 'defaults' do
    it 'fills opened' do
      expect(subject.opened).not_to be_blank
    end
  end

  describe 'scopes' do
    before do
      @open = create_list(:request, 2)
      @closed = create_list(:request, 2, closed: Time.zone.now)
      @archived = create_list(:request, 2, closed: Time.zone.now, archived: Time.zone.now)
    end

    it 'open' do
      ids = @open.map(&:id)

      expect(Request.open.map(&:id)).to match_array ids
    end

    it 'closed' do
      ids = @closed.map(&:id)

      expect(Request.closed.map(&:id)).to match_array ids
    end

    it 'archived' do
      ids = @archived.map(&:id)

      expect(Request.archived.map(&:id)).to match_array ids
    end
  end

  describe '#messages' do
    it 'destroys messages when is destroyed' do
      request = create(:request)
      message = create(:message, request: request)

      request.destroy

      expect { message.reload }.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end

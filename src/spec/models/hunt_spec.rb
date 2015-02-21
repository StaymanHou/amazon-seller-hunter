require 'rails_helper'

RSpec.describe Hunt, :type => :model do
  before do
    allow(Hunter).to receive(:perform_async).and_return(true)
  end

  describe "#create" do
    it 'invokes Hunter.perform_async() with the current hunt id' do
      hunt = Hunt.create(
        isbn: '978-0596514273',
        condition: :new_book,
        status: :pending,
        result: '{}'
      )
      expect(Hunter).to have_received(:perform_async).with(hunt.id)
    end
  end
end

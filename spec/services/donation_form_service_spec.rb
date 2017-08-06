require 'rails_helper'

describe DonationFormService do
  let!(:donation_form_service) { described_class.new }

  describe "#new" do
    it "is initialized with a mechanize agent" do
      expect(donation_form_service.agent).to be_instance_of(Mechanize)
    end
  end
end

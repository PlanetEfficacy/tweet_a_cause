class DonationFormService
  attr_reader :agent
  
  def initialize
    @agent ||= Mechanize.new
  end
end

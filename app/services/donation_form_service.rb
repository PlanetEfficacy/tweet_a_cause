class DonationFormService
  attr_reader :agent

  CHARITY_FORM_URL = 'https://secure.givewell.org/'.freeze

  def initialize
    @agent ||= Mechanize.new
  end

  def page
    agent.get CHARITY_FORM_URL
  end

  def form
    page.forms.first
  end
end

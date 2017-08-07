class DonationFormService

  # Store form mappings and ids as constants
  CHARITY_FORM_URL = 'https://secure.givewell.org/'.freeze
  FORM_ID = 'givewell-braintree-donate-form'.freeze
  FORM_MAPPING = [
    { id: 'edit-transaction-amount-701i0000000nirj', value: 0.10, },
    { id: 'edit-transaction-customer-first-name', value: ENV['FIRST_NAME'] },
    { id: 'edit-transaction-customer-last-name', value: ENV['LAST_NAME'] },
    { id: 'edit-transaction-customer-email', value: ENV['EMAIL'] },
    { id: 'edit-transaction-billing-street-address', value: ENV['STREET_ADDRESS'] },
    { id: 'edit-transaction-billing-locality', value: ENV['LOCALITY'] },
    { id: 'edit-transaction-billing-region', value: ENV['STATE'] },
    { id: 'edit-transaction-billing-postal-code', value: ENV['POSTAL_CODE'] },
    { id: 'edit-transaction-customer-phone', value: ENV['PHONE'] }
  ].freeze
  CREDIT_CARD_FORM_ID = 'braintree-dropin-frame'.freeze
  CREDIT_CARD_FORM_MAPPING = [
    { id: 'credit-card-number', value: ENV['CREDIT_CARD']},
    { id: 'expiration', value: ENV['CREDIT_CARD_EXPIRATION']},
    { id: 'cvv', value: ENV['CREDIT_CARD_CVV']},
    { id: 'postal-code', value: ENV['POSTAL_CODE']},
  ].freeze
  A_FEW_MORE_QUESTIONS_MAPPING = [
    { id: 'edit-dedicate', value: false },
    { id: 'edit-share-my-name', value: false },
    { id: 'edit-newsletter-opt-in', value: false },
  ].freeze
  SHORT_ANSWER = [
    { id: 'edit-hear-about-us', value: 'I learned about GiveWell from the Waking Up podcast, by Sam Harris.' },
    { id: 'edit-comments', value: "This is an automated donation that was created by an application that I wrote to make a donation every time I tweet. Donations are batched in $10.00 increments." }
  ].freeze


  def self.complete_form!
    self.new
  end

  def initialize
    browser.goto(CHARITY_FORM_URL)
    check_one_time_donation
    complete_form
    complete_iframe_form
    answer_a_few_more_questions
    complete_short_answers
    submit_form
  end

  private

  def browser
    @browser ||= Watir::Browser.new(:chrome)
  end

  def complete_form
    FORM_MAPPING.each do |field|
      browser.text_field(id: field[:id]).set field[:value]
    end
  end

  def check_one_time_donation
    browser.radio(id: "edit-transaction-recurring-").set
  end

  def complete_iframe_form
    CREDIT_CARD_FORM_MAPPING.each do |field|
      browser.iframe(id: CREDIT_CARD_FORM_ID).text_field(id: field[:id]).set field[:value]
    end
  end

  def answer_a_few_more_questions
    A_FEW_MORE_QUESTIONS_MAPPING.each do |field|
      browser.checkbox(id: field[:id]).set field[:value]
    end
  end

  def complete_short_answers
    SHORT_ANSWER.each do |field|
      browser.textarea(id: field[:id]).set field[:value]
    end
  end

  def submit_form
    browser.form(id: 'givewell-braintree-donate-form').submit
  end
end

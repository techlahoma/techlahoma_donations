class Sponsorship < ActiveRecord::Base

  PLANS = [
    {
      :name => "User Group Hero",
      :id => "user-group-hero",
      :cost_in_dollars_per_year => 2048,
      :opportunities => 12,
      :benefits => [
        "Website Stratified Recognition props",
        "Choose a month to be recognized as User Group Hero of the month in each Techlahoma technology group meeting."
      ]
    },
    {
      :name => "Bootstrap Funder",
      :id => "bootstrap-funder",
      :cost_in_dollars_per_year => 5120,
      :opportunities => 2,
      :benefits => [
        "Website Stratified Recognition props",
        "Recognition at Tulsa or OKC based Techlahoma technology groups from May 2016 - April 2017"
      ]
    },
    {
      :name => "Angel Investor",
      :id => "angel-investor",
      :cost_in_dollars_per_year => 10240,
      :opportunities => nil,
      :benefits => [
        "Website Stratified Recognition props",
        "Recognition as an Angel Investor at all Techlahoma Technology Group meetings taking place from May 2016 - April 2017. Sponsor can elect to send a representative to speak briefly up to 3 times per Techlahoma Technology Group."
      ]
    }
  ]

  def self.find_plan id
    PLANS.select{|p| p[:id] == id }.first
  end

end

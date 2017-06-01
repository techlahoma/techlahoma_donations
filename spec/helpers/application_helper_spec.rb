require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe "cents_to_dollars" do
    it "changes 100 to '$1.00'" do
      expect(helper.cents_to_dollars(100)).to eq('$1.00')
    end
  end

  describe "page_class" do
    it "joins class names that have been added with add_page_class" do
      helper.add_page_class 'foo'
      helper.add_page_class 'bar'
      expect(helper.page_class).to eq('foo bar')
    end
  end
end

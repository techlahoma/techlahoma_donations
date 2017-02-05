class LetsencryptController < ApplicationController
  def challenge
    render text: 'sb1SiyhA0ZOuWlBidZ0GTik1mWnkR0tmvn0DTRHbR34.jAGCbyEGmhGUoygau6KsU64SmHCdKi_XbyD23BsQjF4'
  end
end

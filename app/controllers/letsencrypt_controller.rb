class LetsencryptController < ApplicationController
  def challenge
    render text: 'fMg7u1mDnstJQ5zY6FVl3DTIX8OLhPKroGtvFYoddQc.jAGCbyEGmhGUoygau6KsU64SmHCdKi_XbyD23BsQjF4'
  end
end

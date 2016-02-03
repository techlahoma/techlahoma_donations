class Plan < ActiveRecord::Base

   INTERVALS = ["day","week","month","year"]

   validates :amount, :numericality => true
   validates :interval, :presence => true
   validates :interval_count, :numericality => true
   validates :name, :presence => true
   validates :stripe_id, :presence => true
end

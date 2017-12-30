class DonationRollUpCreator
  def self.call(start_time, end_time)
    data = Donation
      .select("email, sum(amount) as amount")
      .group("email")
      .where("created_at >= ? and created_at < ?", start_time, end_time)
    data.each do |roll_up_data|
      attrs = roll_up_data.attributes.except(:id)
      attrs = attrs.merge(start_time: start_time, end_time: end_time)
      DonationRollUp.create!(attrs)
    end
  end
end

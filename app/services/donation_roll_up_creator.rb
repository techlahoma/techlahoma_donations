class DonationRollUpCreator
  def self.call(start_time, end_time)
    data = Donation
      .select("email, sum(amount) as amount")
      .group("email")
      .where("created_at >= ? and created_at < ?", start_time, end_time)
    data.each do |roll_up_data|
      DonationRollUp.create!(roll_up_data.attributes.except(:id))
    end
  end
end

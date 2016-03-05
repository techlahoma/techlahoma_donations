  
namespace :donations do
  namespace :stripe_plans do
    desc "Delete all plans in the connected Stripe environment"
    task :delete_all => :environment  do
      Plan.delete_all_stripe_plans
    end

    desc "Create all needed plans in the connected Stripe environment"
    task :create_all => :environment  do
      Plan.create_all_stripe_plans
    end
  end
end

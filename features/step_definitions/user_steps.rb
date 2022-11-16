Given /the following users exist/ do |user_table|
    user_table.hashes.each do |user|
      User.create!(user)
    end
end

Then /(.*) seed users should exist/ do | n_seeds |
    expect(User.count).to eq n_seeds.to_i
end

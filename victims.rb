require "mysql2"

client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "password", :database => "maple")

accounts = client.query("SELECT * FROM accounts WHERE currency=2")

funds = "0".to_f

accounts.each do |account|
  balance = (account["balance"].to_f + account["locked"].to_f)
  funds = (funds + balance)

  member = client.query("SELECT email FROM members WHERE id='#{account["member_id"]}'")
  # puts member.first["email"]
end

puts "[Victims:] #{accounts.count}"
puts "[Funds:] #{funds} WAE"

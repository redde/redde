m = Manager.first || Manager.new
m.email = 'admin@redde.ru'
m.password = '123123aA'
if m.save
  puts '.'
else
  puts m.errors.full_messages
end

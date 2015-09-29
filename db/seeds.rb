# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
member = User.new(
   name:     'Member User',
   email:    'member@example.com',
   password: 'helloworld'
 )
 member.skip_confirmation!
 member.save!

 Categories.create(name:"Cleaning", description: "Vacuum cleaner, mop etc")
 Category.create(name:"Kitchen Appliances", description: "High power blender, espresso maker, ice cream maker, popcorn machinetc")
Category.create(name:"Yard", description: "Leaf Blower, rake, snow shovel wheelbarrow etc")
Category.create(name:"Party Supplies", description: "Table,centerpiece,decorations etc")
Category.create(name:"Furniture", description: "Table,chairs,lawn furniture,inflattable mattress etc")
 Category.create(name:"Sports/Fitness", description: "Camping gear, small inflatable raft, volleyball net, cricket bats,balls etc")
 Category.create(name:"Toys", description: "3 wheeler, play tent, playsand, cycle, scooter etc")
Category.create(name:"Arts/Crafts", description: "paint brush, stamps, sewing machine etc")
Category.create(name:"Travel", description: "duffle bag, rolling suitcase, maps etc")
Category.create(name:"Health", description: "Massage chair, Pressure monitor, humidifier etc")
Category.create(name:"Electronic", description: "DVD Player, Video camera, Camera etc")
Category.create(name:"Other", description: "Miscellaneous items etc")

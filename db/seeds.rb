# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
  Post.create title: "post example #{n}", content: "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Incidunt odio, vel recusandae, id fuga voluptatum sequi temporibus ipsa sint minus quis ex eum amet. Veritatis fugit, labore sapiente repudiandae? Modi!"*10
end
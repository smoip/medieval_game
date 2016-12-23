# require 'contracts'
# require 'celluloid/current'

# require 'field'
# require 'stockpile'
# require 'work_order'
# require 'citizen'

# # 266-381 days worked per year per family
# # 1.13-3.4 d. per day.
# #
# # Interface: ActorCollection
# class Family
#   include Celluloid::Internals::Logger

#   include Contracts::Core
#   include Contracts::Builtin

#   attr_reader :stockpile
#   attr_accessor :fields

#   def initialize(head:, next_in_line:, members:)
#     @name = ""

#     @head_of_family = head
#     @next_in_line = next_in_line
#     @members = members || []

#     @stockpile    = Stockpile.new
#     @fields       = []
#   end

#   def adults
#     @adults ||= members.select {|member| member.adult? }.compact
#   end
#   def children
#     # FIXME: This will not update when the child turns 14
#     @children ||= members.select {|member| member.child? }.compact
#   end

#   Contract nil => ArrayOf[Citizen]
#   def members
#     @members
#   end

#   Contract nil => Num
#   def acreage # Total for Weisbach was 45d/acre
#     fields.map(&:acreage).reduce(:+)
#   end

#   def work
#     members.map(&:work)
#   end

#   Contract nil => ArrayOf[WorkOrder]
#   def work_needed
#     work_orders = []

#     Calendar.months_work_orders.each do |name, needs|
#       type = needs.keys.first
#       values = needs.values.first

#       # info "name: #{name}, type: #{type} values: #{values}"

#       case type
#       when "fixed_per_day"
#         work_orders << WorkOrder.new(
#           work_object: Object.new, # FIXME: Obviously wrong
#           name: name,
#           min_adults: values["min_adults"],
#           max_adults: values["max_adults"],
#           min_children: values["min_children"],
#           max_children: values["max_children"],
#           person_days: values["person_days"]
#         )
#       when "acres_per_day"
#         fields.each do |field|
#           work_orders << WorkOrder.new(
#             work_object: field,
#             name: "#{name} #{field.object_id}",
#             min_adults: values["min_adults"] || 0,
#             max_adults: field.acreage.fdiv(values['per_adult']),
#             person_days: field.acreage.fdiv(values['per_adult'])
#           )
#         end
#       end
#     end

#     return work_orders
#   end
# end

# class WorkOrder
#   include Celluloid::Internals::Logger

#   attr_reader :name
#   attr_accessor :completeness, :adults, :children

#   def initialize(work_object:, name:, min_adults: 0, max_adults: 0, min_children: 0, max_children: 0, person_days:)
#     @work_object  = work_object # Thing we work upon

#     @name         = name
#     @max_adults   = max_adults || 0
#     @max_children = max_children || 0
#     @person_days  = person_days
#     @completeness = 0
#     @adults       = 0
#     @children     = 0
#   end

#   def finished?
#     completeness >= 100
#   end

#   def full?
#     adults == max_adults && children == max_children
#   end

#   def sign_up(child: false)
#     if child == true && children < max_children
#       self.children += 1
#       return true
#     elsif child == false && adults < max_adults
#       self.adults += 1
#       return true
#     else
#       return false
#     end
#   end

#   def empty
#     self.adults = 0
#     self.children = 0
#   end

#   def progress
#     self.completeness += worker_count.fdiv(person_days) * 100

#     # if finished?
#     #   info "DONE! #{name}"
#     # else
#     #   info "Progress: #{completeness} #{name}"
#     # end

#     return nil
#   end

#   def to_s
#     "#{name}: fullness - #{fullness}, progress - #{completeness}"
#   end

#   def fullness
#     (adults + children).fdiv(max_workers)
#   end

#   def max_workers
#     max_adults + max_children
#   end

#   def worker_count
#     adults + children
#   end

#   private

#   attr_reader :needs, :max_adults, :max_children, :person_days, :type
# end

# class BaseJob
#   include Contracts::Core
#   include Contracts::Builtin

#   def initialize(**_args)
#     on_create
#   end

#   def work
#     begin
#       on_work if before_work
#     rescue => e
#       on_rescue
#       raise e
#     ensure
#       on_finalize
#     end
#   end
# end

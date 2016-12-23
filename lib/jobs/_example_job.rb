# require 'jobs/base_job'

# # Interface: Job
# class ExampleJob < BaseJob
#   def initialize(**args)
#     super
#   end

#   protected

#   # Any actions that should be taken while still in sync mode. After this
#   # point should assume async mode.
#   # Example: taking seed stock from a shared barn, marking workers as busy
#   Contract nil => nil
#   def on_create
#   end

#   # Any pre-requisite checks. Async.
#   # Example: checking that we have the minimum number of workers or tools
#   Contract nil => Bool
#   def before_work
#   end

#   # What should actually get done by this job. Async.
#   # Example: Remove seed stock, increase the percentage of the field sown
#   Contract nil => nil
#   def on_work
#   end

#   # What must happen if the thread crashes that we wouldn't already be
#   # doing in on_finalize. Async.
#   # Example: Return unused seed stock (this isn't returned in the finalizer)
#   Contract nil => nil
#   def on_rescue
#   end

#   # What must happen whether the thread completes or not. Async.
#   # Example: Marking workers as not busy (but still tired), releasing the fields
#   Contract nil => nil
#   def on_finalize
#   end

#   private

#   # Random methods that you'll need for the above
# end

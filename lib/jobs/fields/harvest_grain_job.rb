# require 'jobs/base_job'

# # Interface: Job
# class HarvestGrainJob < BaseJob
#   attr_reader :field, :workers, :store

#   def initialize(field:, workers:, store:)
#     @field = field
#     @workers = workers
#     @store = store

#     super
#   end

#   protected

#   Contract nil => nil
#   def on_create
#     workers.map { |worker| worker.busy = true }
#     field.reserve

#     return nil
#   end

#   Contract nil => Bool
#   def before_work
#     return false if workers.count < 5
#     return true
#   end

#   Contract nil => nil
#   def on_work
#     workers.map { |worker| worker.tired = true }
#     # TODO: Check this math
#     field.percent_harvested +=
#       ( acres_processed_per_worker *
#         workers.count
#       ) / field.acreage
#     store.harvested_grain +=
#       acres_processed_per_worker *
#       workers.count *
#       bushels_per_acre

#     return nil
#   end

#   Contract nil => nil
#   def on_rescue
#     return nil
#   end

#   Contract nil => nil
#   def on_finalize
#     field.unreserve
#     workers.map { |worker| worker.busy = false }

#     return nil
#   end

#   private

#   def percent_workers
#     workers.count / desired_num_workers
#   end

#   def desired_num_workers
#     field.acreage / acres_processed_per_worker
#   end

#   def acres_processed_per_worker
#     0.4
#   end

#   def bushels_per_acre
#     # TODO: Import the table of values per grain type
#     7.0
#   end
# end

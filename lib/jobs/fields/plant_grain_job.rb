# require 'jobs/base_job'

# # Interface: Job
# class PlantGrainJob < BaseJob
#   attr_reader :field, :workers, :store

#   def initialize(field:, workers:, store:)
#     @field = field
#     @workers = workers
#     @store = store

#     @reserved_seed_stock_amount = 0

#     super
#   end

#   protected

#   Contract nil => nil
#   def on_create
#     @reserved_seed_stock_amount = store.reserve_seed_stock(desired_seed_stock_amount)
#     workers.map { |worker| worker.busy = true }
#     field.reserve

#     return nil
#   end

#   Contract nil => Bool
#   def before_work
#     return true
#   end

#   Contract nil => nil
#   def on_work
#     store.remove_seed_stock(desired_seed_stock_amount)
#     workers.map { |worker| worker.tired = true }
#     # TODO: Check this math
#     field.percent_sown +=
#       ( acres_processed_per_person *
#         percent_seed_stock *
#         percent_workers # 5.0 acres per personday
#       ) / field.acreage

#     return nil
#   end

#   Contract nil => nil
#   def on_rescue
#     store.unreserve_seed_stock(desired_seed_stock_amount)

#     return nil
#   end

#   Contract nil => nil
#   def on_finalize
#     field.unreserve
#     workers.map { |worker| worker.busy = false }

#     return nil
#   end

#   private

#   def percent_seed_stock
#     @reserved_seed_stock_amount / desired_seed_stock_amount
#   end

#   def percent_workers
#     workers.count / desired_num_workers
#   end

#   def desired_seed_stock_amount
#     field.acreage * bushels_per_acre
#   end

#   def desired_num_workers
#     field.acreage / acres_processed_per_person
#   end

#   def bushels_per_acre
#     # TODO: Import the table of values per grain type
#     2.0
#   end

#   def acres_processed_per_person
#     5.0
#   end
# end

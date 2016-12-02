# frozen_string_literal: true

# Gets list of all groups from API
class GetGroupDetailsAndUpdates
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    details = GetGroupDetails.call(params)
    updates = GetGroupUpdates.call(params)

    if details.success? && updates.success?
      Right(details: details.value, updates: updates.value)
    else
      Left(Error.new('Could not information about this group'))
    end
  end
end

require 'concurrent'

class GetGroupDetailsAndUpdatesAsync
  extend Dry::Monads::Either::Mixin

  def self.call(params)
    details = Concurrent::Promise.execute { GetGroupDetails.call(params) }
    updates = Concurrent::Promise.execute { GetGroupUpdates.call(params) }

    if details.value.success? && updates.value.success?
      Right(details: details.value.value, updates: updates.value.value)
    else
      Left(Error.new('Could not information about this group'))
    end
  end
end

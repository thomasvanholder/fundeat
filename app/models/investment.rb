class Investment < ApplicationRecord
  belongs_to :investor
  belongs_to :campaign_id
  belongs_to :reward_id
end

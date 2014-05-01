class ActsAsTaggableOn < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :tagger, polymorphic: true
end

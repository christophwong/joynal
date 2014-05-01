class ActsAsTaggableOn < ActiveRecord::base
  belongs_to :taggable, polymorphic: true
  belongs_to :tagger, polymorphic: true
end

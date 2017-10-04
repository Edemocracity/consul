# can [:update, :destroy ], Image, :imageable_id => user.id, :imageable_type => 'User'
# and add a feature like forbidden/without_role_images_spec.rb to test it
module Galleryable
  extend ActiveSupport::Concern

  included do
    has_many :images, as: :imageable, dependent: :destroy
    accepts_nested_attributes_for :images, allow_destroy: true, update_only: true

    def image_url(style)
      image.attachment.url(style) if image && image.attachment.exists?
    end
  end
end
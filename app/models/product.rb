class Product < ApplicationRecord
  belongs_to :type
  belongs_to :user
  mount_uploader :image, AttachmentUploader

  def self.to_csv
    attributes = %w{id title detail price type_id type_title username}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |product|
        csv << attributes.map{ |attr| product.send(attr) }
      end
    end
  end
end

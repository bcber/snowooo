class Snowboot
  include Mongoid::Document
  include Mongoid::Timestamps
  
  STYLES = Snowboot.all.pluck(:style).uniq

  def self.create_scope(scopes)
    scopes.each do |s|
      scope s.to_sym, ->{ where(style: s.to_s) }
    end
  end

  create_scope STYLES

  field :name, type: String
  field :brand, type: String
  field :style, type: String

  embeds_many :images, inverse_of: :images
end

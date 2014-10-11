class Snowboard
  include Mongoid::Document
  include Mongoid::Timestamps
  
  LENGTH_OPTIONS = %w{ 142 145 147 148 149 150 151 154 157 159 161.5 162 164.5 165}
  BRAND_OPTIONS = %w{ Arbor Bataleon Burton Capita 
    Compatriot\ Snowboards DC Endeavor\ Snowboards 
    Flow G3 Gnu Head\ Snowboards\ USA Jones\ Snowboards K2\ Snowboards 
    Lib\ Technologies Never\ Summer Niche Nikita Nitro Ride Rome Roxy 
    Salomon\ Snowboards Signal Smokin Stepchild\ Snowboards Voile White\ Gold 
    Yes}

  PROFILE_OPTIONS = %w{ camber Hybrid\ Rocker Hybrid\ Flat Flat Full\ Rocker}
  SHAPE_OPTIONS = %w{ Twin Directional Directional\ Twin Asymmetrical\ Sidecut }
  FLEX_OPTIONS = %w{ Soft Medium Stiff }
  MOUNT_OPTIONS = %w{ Channel 4-hole 3D\ Pattern }

  # property
  field :name, type:String
  field :review, type: Hash
  field :brand, type: String
  field :length, type: Array
  field :profile, type: String
  field :shape, type: String
  field :flex, type: Array
  field :effectiveEdge, type: String
  field :waistWidth, type: String
  field :sidecutRadius, type: String
  field :stanceWidth, type: String
  field :stanceSetback, type: String
  field :mount, type: String
  field :core, type: Array
  field :wrap, type: String
  field :sidewalls, type: String
  field :base, type: String
  field :recommendedRiderWeight, type: Array
  field :recommendedUse, type: String

  embeds_many :images, store_as: "snowboard_imgs"
  accepts_nested_attributes_for :images, reject_if: -> (a) {
    a[:original_url].blank? or a[:full_url].blank?
  }, allow_destroy: true
end

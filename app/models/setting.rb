class Setting
  include Mongoid::Document
  field :key, type: String
  field :value, type: String

  index key:1

  validates_presence_of :key
  validates_uniqueness_of :key

  def self.method_missing(method,*args)
    method_name = method.to_s
    super(method, *args)

  rescue NoMethodError
    if method_name =~ /=$/
      var_name = method_name.gsub('=','')
      value = args.first.to_s

      #save
      if item = find_by_key(var_name)
        item.update_attribute(:value, value)
      else
        Setting.create(key: var_name, value: value)
      end
    else
      Rails.cache.fetch("setting:#{method}") do
        if item = find_by_key(method)
          item.value
        else
          nil
        end
      end
    end
  end

  after_save :update_cache
  def update_cache
    Rails.cache.write("setting:#{self.key}",self.value)
  end

  def self.find_by_key(key)
    where(key: key.to_s).first
  end
end

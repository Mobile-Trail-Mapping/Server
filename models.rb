class Category
  include DataMapper::Resource

  property :id,   Serial
  property :name, String, :required => true

  has n, :points
end

class Condition
  include DataMapper::Resource

  property :id,   Serial
  property :desc, Text, :required => true

  has n, :points
end

class Problem
  include DataMapper::Resource
  include Paperclip::Resource

  property :id,    Serial
  has_attached_file :pic,
                    :storage => :s3,
                    :s3_credentials => {:access_key_id => "AKIAIJUGMKYECWUFG2VQ",
                                        :secret_access_key => "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"},
                    :bucket => "mtm_test_data",
                    :path => "problems/:basename.:extension"

  property :desc,  Text
  property :user,  String
  property :title, String
end

class Photo
  include DataMapper::Resource
  include Paperclip::Resource

  property :id,   Serial
  has_attached_file :pic,
                    :storage => :s3,
                    :s3_credentials => {:access_key_id => "AKIAIJUGMKYECWUFG2VQ",
                                        :secret_access_key => "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"},
                    :bucket => "mtm_test_data",
                    :path => "images/:basename.:extension"

  belongs_to :point
end

class Trail
  include DataMapper::Resource

  property :id,   Serial
  property :name, String, :required => true

  has n, :points
end

class Point
  include DataMapper::Resource
  include Paperclip::Resource

  property :id, Serial
  property :lat,  Float, :required => true
  property :long, Float, :required => true
  property :desc, Text
  property :title, String


  belongs_to  :category
  belongs_to  :condition
  belongs_to  :trail
  has n, :photos
  has n, :connections
end

class Connection
  include DataMapper::Resource

  property :id, Serial
  property :connected_to, Integer, :required => true
  property :connected_from, Integer, :required => true

  belongs_to :point
end

class User
  include DataMapper::Resource

  property :id,     Serial
  property :email,  String, :required => true
  property :pwhash, String, :required => true
end

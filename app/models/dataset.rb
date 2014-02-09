class Dataset < ActiveRecord::Base

  has_many :attributes

  def get_data
    ActiveRecord::Base.connection.execute("select * from #{name}")
  end

end

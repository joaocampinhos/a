class Dataset < ActiveRecord::Base

  has_many :attributes

  def compute_nni(context)
    data = get_data()
    
  end

  def get_data
    ActiveRecord::Base.connection.execute("select * from #{name}")
  end
  
end

class Dataset < ActiveRecord::Base

  has_many :attributes

  def get_data
    ActiveRecord::Base.connection.execute("select * from #{name}")
  end

  def compute_nni
    data = get_data()
    
  end


  

end

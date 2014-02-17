class Dataset < ActiveRecord::Base

  has_many :dataset_attributes, class_name: 'Attribute'

  def compute_nni(context)
    data = get_data()
    
  end

  def get_data
    ActiveRecord::Base.connection.execute("select * from #{name}")
  end

  def get_point_data
    data = get_data
    data.map {|tuple| Spacial::Point.new(latitude: tuple["latitude"].to_f, longitude: tuple["longitude"].to_f)}
  end

  def create_table
    ActiveRecord::Base.connection.execute(%{
      create table #{name} (
        id bigserial primary key,
        latitude decimal(9,6),
        longitude decimal(9,6)
      )
    })
  end

  def insert_tuple(hash)
    ActiveRecord::Base.connection.execute(%{
      insert into #{name} (latitude, longitude) values (#{hash[:latitude]}, #{hash[:longitude]})
    })
  end
  
end

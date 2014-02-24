class Dataset < ActiveRecord::Base
  has_many :dataset_attributes, class_name: 'Attribute'

  def get_data(predicate = nil)
    query = "select * from #{name} "
    query << "where ST_Within(ST_PointFromText('POINT(' || longitude || ' ' || latitude || ')',4326),#{predicate})" if predicate
    ActiveRecord::Base.connection.execute(query)
  end

  def get_point_data
    data = get_data
    data.map {|tuple| Spacial::Point.new(latitude: tuple["latitude"].to_f, longitude: tuple["longitude"].to_f)}
  end

  def create_table(data)
    ActiveRecord::Base.connection.execute(%{
      DROP TABLE IF EXISTS #{name};
      create table #{name} (
        id bigserial primary key,
        latitude decimal(9,6),
        longitude decimal(9,6)
      )
    })
    batch_insert(data)
  end

  def insert_tuple(hash)
    ActiveRecord::Base.connection.execute(%{
      insert into #{name} (latitude, longitude) values (#{hash[:latitude]}, #{hash[:longitude]})
    })
  end
  
private 

  def batch_insert(data)
    tuples = data.map {|tuple| "(#{tuple[:latitude]}, #{tuple[:longitude]})"}.join(",\n")
    ActiveRecord::Base.connection.execute(%{
      insert into #{name} (latitude, longitude) values #{tuples}
    })
  end
end

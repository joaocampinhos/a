class StatisticsController < ApplicationController
  include Geometry

  def index
    statistics = [{id: 'nni', name: 'Nearest Neighbour'}, {id: 'pcf', name: 'Pixel Collision Frequency'}]
    render json: statistics
  end

  def show
    context_data = JSON.parse(params[:context])
    context = build_context(context_data)
    statistic_name = context_data["statistic"]
    Statistics::Statistic.build(statistic_name, context)
    # Trocar a resposta pela informação pa[ra gerar o gráfico
    render json: [1,2,3,4,5,6,7,8,9,10]
  end

protected
  def build_context(context_data)
    map_context = context_data["map"]
    map = build_map(map_context)
    visualization_context = context_data["visualization"]
    visualization = build_visualization(visualization_context)
    dataset = Dataset.find(context_data["dataset"])
    Context::Context.new(map: map, visualization: visualization, dataset: dataset)
  end

  def build_map(map_context)
    canvas_context = map_context["canvas"]
    canvas = build_canvas(canvas_context)
    bounds_context = map_context["bounds"]
    bounds = build_bounds(bounds_context)
    Context::Map.new(canvas: canvas, map_bounds: bounds)
  end

  def build_canvas(canvas_context)
    width = canvas_context["width"]
    height = canvas_context["height"]
    rectangle = Geometry::Rectangle.build_with_dimensions(width: width, height: height)
    Spacial::Canvas.new(rectangle)
  end

  def build_bounds(bounds_context)
    bl_data = bounds_context["bl"]
    bl = Geometry::GpsPoint.new(bl_data["longitude"], bl_data["latitude"])
    tr_data = bounds_context["tr"]
    tr = Geometry::GpsPoint.new(tr_data["longitude"], tr_data["latitude"])
    rectangle = Geometry::Rectangle.build_with_bounds(bl: bl, tr: tr)
    Spacial::MapBounds.new(rectangle)
  end

  def build_visualization(visualization_context)
    name = visualization_context["name"]
    params = visualization_context["params"]
    dot_size = params["size"]
    Visualization.new(name, dot_size: dot_size)
  end

  def fetch_value(hash, key)
    hash[key] || hash[key.to_s]
  end


  Visualization = Struct.new(:name, :params)

end


=begin
{
  map: {
    canvas: {
      width: 1500,
      height: 900
    },
    bounds: {
      bl: {
        latitude: -3.564242,
        longitude: 50.23242
      },
      tr: {
        latitude: -3.564242,
        longitude: 30.23242
      }
    }
  },
  visualization: {
    name: 'DotLayer',
    params: {
      size: 1
    }
  },
  dataset: datasetid
}
=end
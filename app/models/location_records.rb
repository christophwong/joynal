class LocationRecords < ActiveRecord::Base
  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_for_column(:coords, GEOFACTORY.projection_factory)
end

class LocationRecord < ActiveRecord::Base
  belongs_to :journal_entry

  GEOFACTORY = RGeo::Geographic.simple_mercator_factory
  set_rgeo_factory_for_column(:coords, GEOFACTORY.projection_factory)

  def self.in_rect(w, s, e, n)
    sw = GEOFACTORY.point(w, s).projection
    ne = GEOFACTORY.point(e, n).projection
    box = Rgeo::Cartesian::BoundingBox.create_from_points(sw, ne)
    where(["coords && ?", box])
  end
end

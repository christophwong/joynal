class LocationRecord < ActiveRecord::Base
  belongs_to :journal_entry
  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))

  GEOFACTORY = RGeo::Geographic.spherical_factory(:srid => 4326)

  def self.box(sw_lon, sw_lat, ne_lon, ne_lat)


    sw = GEOFACTORY.point(sw_lon, sw_lat)
    nw = GEOFACTORY.point(sw_lon, ne_lat)
    ne = GEOFACTORY.point(ne_lon, ne_lat)
    se = GEOFACTORY.point(ne_lon, sw_lat)

    ring = GEOFACTORY.linear_ring([sw, nw, ne, se])
    # ring = GEOFACTORY.line_string([sw, nw, ne, se])
    box = GEOFACTORY.polygon(ring)

    # window = RGeo::Cartesian::BoundingBox.create_from_points(sw, ne).to_geometry

    where(["location && ?", box])

    # self.where('ST_Intersects(location, :box)', :box => box)

    # where(["location && ?", box])

  end

end

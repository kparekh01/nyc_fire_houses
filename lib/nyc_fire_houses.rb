require "nyc_fire_houses/version"
require "unirest"

module NycFireHouses

  class FireHouse
    attr_reader :borough, :facilityaddress, :facilityname

    def initialize(fire_house)
      @borough = fire_house["borough"]
      @name = fire_house["facilityname"]
      @addrress = fire_house["facilityaddress"]
    end

    def self.all
        fire_house_array = Unirest.get('https://data.cityofnewyork.us/resource/byk8-bdfw.json').body
        create_fire_houses(fire_house_array)
    end

    def self.where(fire_house)
       key = fire_house.keys.first.to_s
       value = fire_house.values.first
       fire_house_array = Unirest.get("https://data.cityofnewyork.us/resource/byk8-bdfw.json?#{key}=#{value}").body
       create_fire_houses(fire_house_array)
    end

    def self.create_fire_houses(fire_house_array)
      fire_house_array.map { |fire_house| FireHouse.new(fire_house)}
    end

    private_class_method :create_fire_houses


  end
end

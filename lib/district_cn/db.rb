require 'json'
module DistrictCn
  module Db
    class File 
      attr_reader :tree,:list

      def provinces
        @provinces ||= @tree.map{|pvn_id,pvn_hash| [pvn_hash[:text],pvn_id]}
      end

      def initialize
        @tree = {}
        @list = {}
        parse
      end

      class << self
        def instance
          @instance ||= new
        end

        def provinces
          instance.provinces
        end

        def tree
          instance.tree
        end

        def list
          instance.list
        end

        private :new
      end

      private 
      def code_regular
        DistrictCn::Code::REGULAR
      end

      def path
        ::File.expand_path("../../areas.json",  __FILE__)
      end

      def json_data
        @json_data ||= JSON.parse(::File.read(path))
      end

      def parse 
        json_data["province"].each do |province|
          @tree[province["id"]] = {:text => province["text"],:children => {}}

          @list[province["id"]] = province["text"]
        end

        json_data["city"].each do |city|
          city["id"] =~ (code_regular)
          province_id = $1.ljust(6, '0')
          if @tree[province_id]
            @tree[province_id][:children][city["id"]] = {:text => city["text"], :children => {}}

            @list[city["id"]] = city["text"]
          end
        end

        json_data["district"].each do |district|
          district["id"] =~ (code_regular)
          province_id = $1.ljust(6, '0')
          city_id = "#{$1}#{$2}".ljust(6, '0')
          if @tree[province_id] && @tree[province_id][:children][city_id]
            @tree[province_id][:children][city_id][:children][district["id"]] = {:text => district["text"]}

            @list[district["id"]] = district["text"]
          end
        end
      end

    end
  end
end

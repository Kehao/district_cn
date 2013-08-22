module DistrictCn
  class Code
    include AsOptions

    REGULAR = /(\d{2})(\d{2})(\d{2})/ 
    attr_reader :value,:id

    def initialize(id)
      @value = id
      @id = id.to_s
    end

    def name
      get && get[:text]
    end

    def area_name(mark="-")
      [province_name,city_name,district_name].compact.join(mark) 
    end

    def children
      return [] unless get && get[:children]

      get[:children].map{|id,attr| [attr[:text],id] }
    end


    def get
      @get ||= province? && province
      @get ||= city? && city
      @get ||= district? && district
      @get || nil
    end

    def province?
      !!(province_id && city_id.nil?)
    end

    def city?
      !!(province_id && city_id && district_id.nil?)
    end

    def district?
      !!(province_id && city_id && district_id)
    end

    def province
      @province ||=
      province_id && self.class.data && self.class.data[province_id]
    end

    def city
      city_id && province && province[:children][city_id]
    end

    def district
      district_id && city && city[:children][district_id]
    end

    def province_name
      province && province[:text]
    end

    def city_name
      city && city[:text]
    end

    def district_name
      district && district[:text]
    end

    def province_id
      @province_id ||= 
        if match && segment_blank?(match[1])
          match[1].ljust(6, '0')
        end
    end

    def city_id 
      @city_id ||= 
        if match && segment_blank?(match[2])
          "#{match[1]}#{match[2]}".ljust(6, '0')
        end
    end

    def district_id
      @district_id ||= 
        if match && segment_blank?(match[3])
          id
        end
    end

    private
    def match 
      @match ||= id.match(REGULAR)
    end

    def segment_blank?(segment)
      segment != "00"
    end

    def self.data
      @data ||= Db::File.instance.tree
    end

  end
end

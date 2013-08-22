require "district_cn/version"
require "active_support/core_ext/module/delegation"
require "active_support/core_ext/object/blank"

module DistrictCn
  autoload :AsOptions, 'district_cn/as_options'
  autoload :Code,      'district_cn/code'
  autoload :Db,        'district_cn/db'

  class << self

    def code(id)
      return id if id.blank?
      Code.new(id)
    end

    def search(text,limit=10)
      results = []
      list.each do |id,name|
        break if results.size.eql?(limit)

        if name =~ /#{text}/ 
          results << Code.new(id)
        end
      end
      results
    end

    delegate :provinces,:tree,:list, :to => Db::File 
  end

end

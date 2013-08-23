[![Gem Version](https://badge.fury.io/rb/area_cn.png)](http://badge.fury.io/rb/district_cn)
# DistrictCn

地区码查询

## Installation

Add this line to your application's Gemfile:

    gem 'district_cn'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install district_cn

## Usage
### DistrictCn::Code

```ruby
# new
DistrictCn.Code(331002) # or DistrictCn::Code.new(331002)

# Instance methods 
code = DistrictCn.code(331000)
=> #<DistrictCn::Code:0x007fd5c48e3590 @value=331000, @id="331000"> 
code.value                     #=> 331000   #原始输入的地区码
code.id                        #=> "331000" #code.value.to_s
code.name                      #=> "台州市"
code.area_name(default = "-")  #=> "浙江省-台州市"

code.province?                 #=> false
code.province                  #=> {:text=>"浙江省",:children=>{...}}
code.province_id               #=> "330000"
code.province_name             #=> "浙江省"

code.city?                     #=> true
code.city                      #=> {:text=>"台州市",:children=>{...}}
code.city_id                   #=> "331000"
code.city_name                 #=> "台州市"

code.district?                 #=> false
code.district                  #=> nil
code.district_id               #=> nil
code.district_name             #=> nil

code.children
#=>[["黄岩区", "331003"],
#   ["椒江区", "331002"],
#   ["临海市", "331082"],
#   ["路桥区", "331004"],
#   ["三门县", "331022"],
#   ["市辖区", "331001"],
#   ["天台县", "331023"],
#   ["温岭市", "331081"],
#   ["仙居县", "331024"],
#   ["玉环县", "331021"]]

id.as_options
# => 返回生成select需要的数据
```
### DistrictCn
```ruby
codes = DistrictCn.search("浙江")
#=> [#<DistrictCn::Code:0x007fd5c483f990 @value="330000", @id="330000">]
codes.first.name
#=> "浙江省"

DistrictCn.tree #树状结构数据
DistrictCn.list #数据列表
```
## 使用act_as_area_field 简化调用
```ruby
#company.rb
class Company < ActiveRecord::Base
  attr_accessor :region_code
  attr_accessible :region_code

  act_as_area_field :region_code #增加这一行
  validates :region_code, presence: true
end
```
```ruby
company = Company.new
company.region_code = 331002
#不使用act_as_area_field
company.region_code 
#=> 331002
District::Cn.code(company.region_code).name
#=> "椒江区"

#使用act_as_area_field
company.region_code 
#返回District::Cn::code对像
#=> #<District::Cn::code:0x007fb7a4c0e960 @value=331002, @id="331002">
company.region_code.name
#=> "椒江区"
```



## Test
```ruby
rake spec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

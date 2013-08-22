# encoding: utf-8
require 'spec_helper'
describe DistrictCn::Code do
  let!(:code_331002){ DistrictCn::Code.new(331002) }

  it ".value should return real value" do
    expect(code_331002.value).to eq(331002)
    expect(DistrictCn::Code.new("331002").value).to eq("331002")
  end

  it ".id should return region_code.to_s" do
    expect(code_331002.id).to eq("331002")
    expect(DistrictCn::Code.new("331002").id).to eq("331002")
  end

  it "should return province_id" do
      expect(DistrictCn::Code.new("00000a").province_id).to be_nil
      expect(DistrictCn::Code.new("000000").province_id).to be_nil
      expect(DistrictCn::Code.new("330000").province_id).to eq("330000")
      expect(DistrictCn::Code.new("331000").province_id).to eq("330000")
      expect(DistrictCn::Code.new("331002").province_id).to eq("330000")
  end

  it "should return city_id" do
    expect(DistrictCn::Code.new("00000a").city_id).to be_nil
    expect(DistrictCn::Code.new("000000").city_id).to be_nil
    expect(DistrictCn::Code.new("330000").city_id).to be_nil
    expect(DistrictCn::Code.new("331000").city_id).to eq("331000")
    expect(DistrictCn::Code.new("331002").city_id).to eq("331000")
  end

  it "should return district_id" do
    expect(DistrictCn::Code.new("00000a").district_id).to be_nil
    expect(DistrictCn::Code.new("000000").district_id).to be_nil
    expect(DistrictCn::Code.new("330000").district_id).to be_nil
    expect(DistrictCn::Code.new("331000").district_id).to be_nil
    expect(DistrictCn::Code.new("331002").district_id).to eq("331002")
  end

  it "should return area type" do
    expect(DistrictCn::Code.new("330000")).to be_province
    expect(DistrictCn::Code.new("330000")).not_to be_city
    expect(DistrictCn::Code.new("330000")).not_to be_district

    expect(DistrictCn::Code.new("331000")).to be_city
    expect(DistrictCn::Code.new("331000")).not_to be_province
    expect(DistrictCn::Code.new("331000")).not_to be_district

    expect(DistrictCn::Code.new("331002")).to be_district
    expect(DistrictCn::Code.new("331002")).not_to be_city
    expect(DistrictCn::Code.new("331002")).not_to be_province
  end

  it "should return privince,city,district name" do
    expect(DistrictCn::Code.new("331002").province_name).to eq("浙江省")
    expect(DistrictCn::Code.new("331002").city_name).to eq("台州市")
    expect(DistrictCn::Code.new("331002").district_name).to eq("椒江区")

    expect(DistrictCn::Code.new("330000").city_name).to be_nil
    expect(DistrictCn::Code.new("330000").district_name).to be_nil
  end

  it "should get detail area" do
    expect(DistrictCn::Code.new("330000").get[:children]).not_to be_empty
    expect(DistrictCn::Code.new("331000").get[:children]).not_to be_empty
    expect(DistrictCn::Code.new("331002").get[:children]).to be_nil
  end

  it "should get children" do
    expect(DistrictCn::Code.new("330000").children).to be_include(["台州市", "331000"])
    expect(DistrictCn::Code.new("330000").children).not_to be_include(["椒江区", "331002"])

    expect(DistrictCn::Code.new("331000").children).to be_include(["椒江区", "331002"])
    expect(DistrictCn::Code.new("331002").children).to be_empty
  end

  it "should get area name" do
      expect(DistrictCn::Code.new("330000").area_name).to eq("浙江省")
      expect(DistrictCn::Code.new("331000").area_name).to eq("浙江省-台州市")
      expect(DistrictCn::Code.new("331002").area_name).to eq("浙江省-台州市-椒江区")
  end

  context "as options" do
    it "should return selected" do
      options = DistrictCn::Code.new("330000").as_options
      expect(options[:selected_provinces]).not_to be_empty
      expect(options[:selected_cities]).not_to be_empty
      expect(options[:selected_districts]).to be_empty

      options = DistrictCn::Code.new("331000").as_options
      expect(options[:selected_provinces]).not_to be_empty
      expect(options[:selected_cities]).not_to be_empty
      expect(options[:selected_districts]).not_to be_empty

      options = DistrictCn::Code.new("331002").as_options
      expect(options[:selected_provinces]).not_to be_empty
      expect(options[:selected_cities]).not_to be_empty
      expect(options[:selected_districts]).not_to be_empty
    end

  end

end


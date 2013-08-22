# encoding: utf-8
require 'spec_helper'
describe DistrictCn do
  it ".code should return \"\" or nil" do
    expect(DistrictCn.code(nil)).to be_nil
    expect(DistrictCn.code(" ")).to be_blank
  end

  it ".code should build DistrictCn::Code" do
    expect(DistrictCn.code("331002")).to be_an_instance_of(DistrictCn::Code)
    expect(DistrictCn.code("33100a")).to be_an_instance_of(DistrictCn::Code)
  end

  it "search" do
    codes = DistrictCn.search("浙江")
    expect(codes.first).to be_an_instance_of(DistrictCn::Code)
    expect(codes.first.name).to eq("浙江省")

    codes = DistrictCn.search("浙江a")
    expect(codes).to be_blank
  end
end

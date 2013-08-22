# encoding: utf-8
require 'spec_helper'
describe DistrictCn::Db do
  context "file" do
    subject { DistrictCn::Db::File.instance }

    it "should be cached" do
      expect(subject.object_id).to eq(DistrictCn::Db::File.instance.object_id)
    end

    it "tree should be present" do
      expect(subject.tree).not_to be_empty
      expect(subject.tree["330000"]).not_to be_nil
      expect(subject.tree['330000'][:text]).to eq("浙江省")
      expect(subject.tree['330000'][:children]).not_to be_empty
    end

    it "list should be present" do
      expect(subject.list).not_to be_empty
      expect(subject.list["330000"]).to eq("浙江省")
      expect(subject.list["331000"]).to eq("台州市")
      expect(subject.list["331002"]).to eq("椒江区")
    end

    it "provinces should be present" do
      expect(subject.provinces).not_to be_empty
      expect(subject.provinces).to be_include(["浙江省","330000"])
      expect(subject.provinces).not_to be_include(["台州市","331000"])
    end

  end
end

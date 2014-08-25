#! /usr/bin/env ruby -S rspec
require 'spec_helper'
require 'facter/hostfacts'


describe 'hostfact_environment', :type => :fact do
  before { Facter.clear }
  after { Facter.clear }

  context "Hostname is test-role-01" do
      before do
        Facter.fact(:hostname).stubs(:value).returns("test-role-01")
      end

      it "should return 'test'" do
        expect(Facter.fact(:hostfact_environment).value).to eq("test")
      end

      it "should return 'role'" do
        expect(Facter.fact(:hostfact_role).value).to eq("role")
      end

      it "should return '01'" do
        expect(Facter.fact(:hostfact_node_number_raw).value).to eq("01")
      end

      it "should return integer 1" do
        expect(Facter.fact(:hostfact_node_number).value).to eq(1)
      end
  end

  context "Hostname is acc-invalid-host" do
      before do
        Facter.fact(:hostname).stubs(:value).returns("acc-invalid-host")
      end

      it "should return 'acc'" do
        expect(Facter.fact(:hostfact_environment).value).to eq("acc")
      end

      it "should return 'invalid'" do
        expect(Facter.fact(:hostfact_role).value).to eq("invalid")
      end

      it "should return nil" do
        expect(Facter.fact(:hostfact_node_number_raw)).to eq(nil)
      end

      it "should return nil" do
        expect(Facter.fact(:hostfact_node_number)).to eq(nil)
      end
  end

end

require 'rails_helper'

describe Message do

  context "associations" do
    it { should have_many :secrets }
    it { should have_many :users }
  end

  context "validations" do
    it {should validate_presence_of :content}
  end

end

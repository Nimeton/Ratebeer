require 'spec_helper'

#describe Beer do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

describe Beer do
  let(:style){ FactoryGirl.create(:style) }

  it "is not saved if it doesn't have a name" do
    beer = Beer.create :style => style

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved if it doesn't have a style" do
    beer = Beer.create :name => "Testiolut"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

end

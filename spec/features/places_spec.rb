require 'spec_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    BeermappingAPI.stub(:places_in).with("kumpula").and_return( [  Place.new(:name => "Oljenkorsi", :id => 1) ] )

    visit places_path
    fill_in('city', :with => 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if multiple places are returned by the API, they are all shown at the page" do

    BeermappingAPI.stub(:places_in).with("mikkeli").and_return([ Place.new(:id => 2, :name => "KB"),
                                                                   Place.new(:id => 3, :name => "Pate"),
                                                                   Place.new(:id => 4, :name => "Wilhelm") ])
    visit places_path
    fill_in('city', :with => 'mikkeli')
    click_button "Search"

    expect(page).to have_content "KB"
    expect(page).to have_content "Pate"
    expect(page).to have_content "Wilhelm"
  end

  it "if none is returned by the API, a notice is shown at the page" do

    BeermappingAPI.stub(:places_in).with("asdasd").and_return([])
    
    visit places_path
    fill_in('city', :with => 'asdasd')
    click_button "Search"

    expect(page).to have_content "No locations in asdasd"
  end

end

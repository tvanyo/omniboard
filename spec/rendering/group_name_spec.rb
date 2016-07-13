require_relative "../spec_helper"

# Ensure that naming a group causes the group to be named appropriately
describe "config.rb group_name:" do
  it "should cause a group to be given the correct name" do
   
    # Set up 
    d = Rubyfocus::Document.new
    Omniboard::document = d

    c = Omniboard::Column.new("Default"){ group_by{ |p| p.note } }
    c << Rubyfocus::Project.new(d, name: "A sample project", note: "This my note", id: "1")
    expect(render c).to  include("<h3>This my note</h3>")

    Omniboard::Column.config{ group_name{ |i| "{{" + i + "}}" } }
    expect(render c).to include("<h3>{{This my note}}</h3>")

    c.group_name{ |i| "Note: #{i}" }
    expect(render c).to include("<h3>Note: This my note</h3>")
  end
end
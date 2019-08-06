require 'rails_helper'

RSpec.describe ShortLinksController, type: :controller do
    subject(:controllerSample) { ShortLinksController.new }
    context "output of new method" do
        it "creates a new model of short_link" do
            expect(controllerSample.new).to have_attributes( :id => nil, :original_url => nil, :view_count => 0, :created_at => nil, :updated_at => nil)
        end
    end
end

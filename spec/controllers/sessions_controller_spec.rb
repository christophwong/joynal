require 'spec_helper'

describe SessionsController do
	describe "GET 'new'" do
		render_views
		it "should be successful" do
			@request.env["devise.mapping"] = Devise.mappings[:user]
			get :new
			response.should be_success
		end
	end
end

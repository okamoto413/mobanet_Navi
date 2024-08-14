require "rails_helper"

RSpec.describe RecommendedPlansController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/recommended_plans").to route_to("recommended_plans#index")
    end

    it "routes to #new" do
      expect(get: "/recommended_plans/new").to route_to("recommended_plans#new")
    end

    it "routes to #show" do
      expect(get: "/recommended_plans/1").to route_to("recommended_plans#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/recommended_plans/1/edit").to route_to("recommended_plans#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/recommended_plans").to route_to("recommended_plans#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/recommended_plans/1").to route_to("recommended_plans#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/recommended_plans/1").to route_to("recommended_plans#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/recommended_plans/1").to route_to("recommended_plans#destroy", id: "1")
    end
  end
end

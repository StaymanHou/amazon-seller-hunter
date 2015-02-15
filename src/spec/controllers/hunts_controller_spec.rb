require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe HuntsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Hunt. As you add validations to Hunt, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:hunt)
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for(:hunt, :invalid)
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HuntsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all hunts as @hunts" do
      hunt = Hunt.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:hunts)).to eq([hunt])
    end
  end

  describe "GET show" do
    it "assigns the requested hunt as @hunt" do
      hunt = Hunt.create! valid_attributes
      get :show, {:id => hunt.to_param}, valid_session
      expect(assigns(:hunt)).to eq(hunt)
    end
  end

  describe "GET new" do
    it "assigns a new hunt as @hunt" do
      get :new, {}, valid_session
      expect(assigns(:hunt)).to be_a_new(Hunt)
    end
  end

  # describe "GET edit" do
  #   it "assigns the requested hunt as @hunt" do
  #     hunt = Hunt.create! valid_attributes
  #     get :edit, {:id => hunt.to_param}, valid_session
  #     expect(assigns(:hunt)).to eq(hunt)
  #   end
  # end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Hunt" do
        expect {
          post :create, {:hunt => valid_attributes}, valid_session
        }.to change(Hunt, :count).by(1)
      end

      it "assigns a newly created hunt as @hunt" do
        post :create, {:hunt => valid_attributes}, valid_session
        expect(assigns(:hunt)).to be_a(Hunt)
        expect(assigns(:hunt)).to be_persisted
      end

      it "redirects to the created hunt" do
        post :create, {:hunt => valid_attributes}, valid_session
        expect(response).to redirect_to(Hunt.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hunt as @hunt" do
        post :create, {:hunt => invalid_attributes}, valid_session
        expect(assigns(:hunt)).to be_a_new(Hunt)
      end

      it "re-renders the 'new' template" do
        post :create, {:hunt => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  # describe "PUT update" do
  #   describe "with valid params" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested hunt" do
  #       hunt = Hunt.create! valid_attributes
  #       put :update, {:id => hunt.to_param, :hunt => new_attributes}, valid_session
  #       hunt.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "assigns the requested hunt as @hunt" do
  #       hunt = Hunt.create! valid_attributes
  #       put :update, {:id => hunt.to_param, :hunt => valid_attributes}, valid_session
  #       expect(assigns(:hunt)).to eq(hunt)
  #     end

  #     it "redirects to the hunt" do
  #       hunt = Hunt.create! valid_attributes
  #       put :update, {:id => hunt.to_param, :hunt => valid_attributes}, valid_session
  #       expect(response).to redirect_to(hunt)
  #     end
  #   end

  #   describe "with invalid params" do
  #     it "assigns the hunt as @hunt" do
  #       hunt = Hunt.create! valid_attributes
  #       put :update, {:id => hunt.to_param, :hunt => invalid_attributes}, valid_session
  #       expect(assigns(:hunt)).to eq(hunt)
  #     end

  #     it "re-renders the 'edit' template" do
  #       hunt = Hunt.create! valid_attributes
  #       put :update, {:id => hunt.to_param, :hunt => invalid_attributes}, valid_session
  #       expect(response).to render_template("edit")
  #     end
  #   end
  # end

  # describe "DELETE destroy" do
  #   it "destroys the requested hunt" do
  #     hunt = Hunt.create! valid_attributes
  #     expect {
  #       delete :destroy, {:id => hunt.to_param}, valid_session
  #     }.to change(Hunt, :count).by(-1)
  #   end

  #   it "redirects to the hunts list" do
  #     hunt = Hunt.create! valid_attributes
  #     delete :destroy, {:id => hunt.to_param}, valid_session
  #     expect(response).to redirect_to(hunts_url)
  #   end
  # end

end

require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/timeslots", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Timeslot. As you add validations to Timeslot, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the headers
  # in order to pass any filters (e.g. authentication) defined in
  # TimeslotsController, or in your router and rack
  # middleware. Be sure to keep this updated too.
  let(:valid_headers) {
    {}
  }

  describe "Get /timeslot" do
    it "with param available, should render only available" do
      @phase = FactoryBot.create(:phase)
      @birth = FactoryBot.create(:birth, phase: @phase)

      @interaction_for_1_person = FactoryBot.create(:interaction, allowed_attendees: 1, phase: @phase, allowed_times_a_day: 5)
      @interaction_for_2_persons = FactoryBot.create(:interaction, allowed_attendees: 2, phase: @phase, allowed_times_a_day: 5)

      @timeslot_1 = Timeslot.create(from: Date.today, to: Date.today, birth_id: @birth.id, interaction_id: @interaction_for_1_person.id)
      @timeslot_2 = Timeslot.create(from: Date.today, to: Date.today, birth_id: @birth.id, interaction_id: @interaction_for_2_persons.id)

      @vds_1 = FactoryBot.create(:user, is_pmc: false)
      @vds_2 = FactoryBot.create(:user, is_pmc: false)

      @timeslot_1_users = TimeslotUser.create(timeslot_id: @timeslot_1.id, user_id: @vds_1.id)
      @timeslot_2_users = TimeslotUser.create(timeslot_id: @timeslot_2.id, user_id: @vds_2.id)

      @vds_3 = FactoryBot.create(:user, is_pmc: false)
      sign_in(@vds_3)

      get '/timeslots',
          params: { birth_id: @birth.id, available:true },
          headers: valid_headers

      timeslots = JSON.parse(response.body)
      expect(timeslots.length()).to eq(1)

      expect(timeslots[0]['id']).to eq(@timeslot_2.id)
    end

    it "should return only timeslots of given birth" do
      @phase = FactoryBot.create(:phase)
      @birth_1 = FactoryBot.create(:birth, phase: @phase)
      @birth_2 = FactoryBot.create(:birth, phase: @phase)

      @timeslot_birth_1 = Timeslot.create(from: Date.today, to: Date.today, birth_id: @birth_1.id)
      @timeslot_birth_2 = Timeslot.create(from: Date.today, to: Date.today, birth_id: @birth_2.id)

      @vds = FactoryBot.create(:user, is_pmc: false)
      sign_in(@vds)

      get '/timeslots',
          params: { birth_id: @birth_1.id, available:true },
          headers: valid_headers

      timeslots = JSON.parse(response.body)
      expect(timeslots.length()).to eq(1)
      expect(timeslots[0]['id']).to eq(@timeslot_birth_1.id)

      sign_in(@vds)
      get '/timeslots',
          params: { birth_id: @birth_2.id, available:true },
          headers: valid_headers

      timeslots = JSON.parse(response.body)
      expect(timeslots.length()).to eq(1)
      expect(timeslots[0]['id']).to eq(@timeslot_birth_2.id)
    end
  end

  describe "GET /index" do
    it "renders a successful response" do
      Timeslot.create! valid_attributes
      get timeslots_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      timeslot = Timeslot.create! valid_attributes
      get timeslot_url(timeslot), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Timeslot" do
        expect {
          post timeslots_url,
               params: {interaction: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Timeslot, :count).by(1)
      end

      it "renders a JSON response with the new timeslot" do
        post timeslots_url,
             params: {interaction: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Timeslot" do
        expect {
          post timeslots_url,
               params: {interaction: invalid_attributes }, as: :json
        }.to change(Timeslot, :count).by(0)
      end

      it "renders a JSON response with errors for the new timeslot" do
        post timeslots_url,
             params: {interaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested timeslot" do
        timeslot = Timeslot.create! valid_attributes
        patch timeslot_url(timeslot),
              params: {interaction: new_attributes }, headers: valid_headers, as: :json
        timeslot.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the timeslot" do
        timeslot = Timeslot.create! valid_attributes
        patch timeslot_url(timeslot),
              params: {interaction: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the timeslot" do
        timeslot = Timeslot.create! valid_attributes
        patch timeslot_url(timeslot),
              params: {interaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested timeslot" do
      timeslot = Timeslot.create! valid_attributes
      expect {
        delete timeslot_url(timeslot), headers: valid_headers, as: :json
      }.to change(Timeslot, :count).by(-1)
    end
  end
end

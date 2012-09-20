require "minitest_helper"

module Thincloud::Authentication
  describe SessionsController do
    describe "GET new" do
      before { get :new }

      it { assert_response :success }
      it { assert_template :new }
    end

    describe "DELETE destroy" do
      before { delete :destroy }

      it { assert_response :redirect }
      it { flash[:notice].must_equal "You have been logged out." }
    end

    describe "GET authenticated" do
      describe "not logged in" do
        before { get :authenticated  }

        it { assert_response :redirect }
        it { assert_redirected_to login_url }
        it { flash[:alert].must_equal "You must be logged in to continue." }
      end

      describe "logged in" do
        before do
          User.stubs(:find).with(123).returns(User.new)
          session[:uid] = 123
          get :authenticated
        end

        it { assert_response :success }
      end
    end
  end
end
class RegistrationsController < Devise::RegistrationsController
before_action :configure_permitted_parameters, if: :only => [:create]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email,
                                                            :password,
                                                            :password_confirmation,
                                                            :employment_status, 
                                                            :gender, 
                                                            :birthday, 
                                                            :city, 
                                                            :relationship_status)}
  end
end
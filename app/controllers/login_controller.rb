class LoginController < ApplicationController
  def login
    @wrong = params[:wrong]
  end

  def select
    admin = Admin.find_by({user_name: params[:user_name].downcase})
    student = Student.find_by({email: params[:user_name]})

    if admin && admin.authenticate(params[:password])
      # store their id in session
      session[:admin_id] = admin.id
      # redirect_to admin_search_path
      redirect_to "/admin/search"
    elsif student && student.authenticate(params[:password])
      # binding.pry
      # store their id in session
      session[:student_id] = student.id
      redirect_to "/students/#{student.id}/edit"
      # redirect_to edit_student(student)
    else
      # rerender the form
      # redirect_to login_path
      redirect_to "/login?wrong=true"
    end
  end

  def destroy
    # remove the user_id from session
    session[:admin_id] = session[:student_id] = nil
    redirect_to '/login'
  end
end

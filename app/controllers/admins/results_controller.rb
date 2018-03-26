class Admins::ResultsController < Admins::AdminsController

  def index
    @subjects = Subject.all
    @q = User.search params[:q]
    @users = @q.result.includes(:subjects, :results).student.get_year(DateTime.now.year)
      .user_newest.page(params[:page]).per Settings.per_page
    @page = params[:page] || 1
  end

  def show
    @subjects = Subject.all
    @q = User.search params[:q]
    @users = @q.result.includes(:subjects, :results).student.get_year(DateTime.now.year)
      .user_newest.page(params[:page]).per Settings.per_page
    @page = params[:page] || 1
  end

  def create
    user = User.find_by identification_number: params[:result][:user]
    results = []
    if user
      if params[:subject] && params[:mark]
        params[:subject].each.with_index do |id, i|
          result_return = Result.where subject_id: id, user_id: user.id
          if result_return.blank?
            result = user.results.new subject_id: id, user_id: user.id, mark: params[:mark][i]
            results << result
          end
        end
        Result.import results
        flash[:success] = t "import_sucess"
      else
        flash[:danger] = t "please_fill"
      end
    else
      flash[:danger] = t "cant_find_user"
    end
    redirect_to action: "index"
  end

  def import_results
    if params[:file].present?
      if Result.open_spreadsheet(params[:file]) == Settings.error_import
        flash[:danger] = t("errors_file_format")
      else
        if Result.import_file(params[:file]) == Settings.error_data
          flash[:danger] = t("errors_file_user")
        else
          flash[:success] = t("import_success")
        end
      end
    else
      flash[:danger] = t("import_file")
    end
    redirect_to action: "index"
  end

  def update
    @flash = ""
    user = User.find_by id: params[:id]
    subject = Subject.find_by id: params[:subject_id]
    if user && subject
      case params[:role]
      when "none"
        result = Result.new user_id: user.id, subject_id: subject.id,
          mark: params[:mark]
        unless result.save
          @flash = t("process_errors")
        end
      else
        result = Result.find_by id: params[:role].to_i
        unless result.update_attribute :mark, params[:mark]
          @flash = t("process_errors")
        end
      end
    else
      @flash = t("process_errors")
    end
    @subjects = Subject.all
    @q = User.search params[:q]
    @users = @q.result.includes(:subjects, :results).student.get_year(DateTime.now.year)
      .user_newest.page(params[:page]).per Settings.per_page
    @page = params[:page] || 1
  end
end

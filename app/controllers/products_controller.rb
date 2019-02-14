class ProductsController < ApplicationController
  before_action :check_signin
  def index
  #  session[:ruby] = "OK Session" #ตัวแปล session ชื่อ ruby
  #  session[:rails] = "OK Session Rails"
  #  cookies[:ruby] = { value: 'Ok Cookies Ruby Expires', expires: 1.hour.from_now}
    #reset_session #delete all session
  #  session.delete(:ruby)
    #@product = Product.joins(:type)
    @product = Product.select( 'products.*, types.title AS type_title, types.id AS type_id, username').joins(:type, :user)
    respond_to do |format|
      format.html
      format.csv { send_data @product.to_csv,filename: "products-#{Date.today}.csv"  }
      #format.xls
    end
  end

  def show
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
    #:user_id = session[:userid]
      if @product.save
        redirect_to action: 'index'
      else
        render 'new'
      end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to action: 'index'
  end

  def search
    @product = Product.select( 'products.*, types.title AS type_title, types.id AS type_id, username').where("products.title LIKE ? OR products.detail LIKE ? OR products.price LIKE ? OR type_title LIKE ? OR username LIKE ?", "%#{params[:form][:search]}%", "%#{params[:form][:search]}%", "%#{params[:form][:search]}%", "%#{params[:form][:search]}%", "%#{params[:form][:search]}%").joins(:type, :user)
    @search = params[:form][:search]
    render 'index'

  end

  def export
  @product = Product.select( 'products.*, types.title AS type_title, types.id AS type_id, username').joins(:type, :user)
  respond_to do |format|
    format.html
    format.csv { send_data @product.to_csv,filename: "products-#{Date.today}.csv" }
  end
    redirect_to action: 'index'
  end

  def exportjson
    @product = Product.select( 'products.id, products.title, products.detail, products.price, types.title AS type_title, types.id AS type_id, username').joins(:type, :user).to_json
    #data = Product.all.to_json
    send_data @product, :type => 'application/json; header=present', :disposition => "attachment; filename=products.json"
    #render 'index'
  end



  private
  def product_params

    params.require(:product).permit( :title, :detail, :price, :type_id, :user_id, :image)

  end
end

class TypesController < ApplicationController
  def new
    @type = Type.new
  end

  def show
    @type = Type.find(params[:id]) #find == select * form where
  end

  def update
    @type = Type.find(params[:id])
    if @type.update(type_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def edit
    @type = Type.find(params[:id])
  end

  def index
    @type = Type.all #select *
  end
  def destroy
    @type = Type.find(params[:id])
    @type.destroy
    redirect_to action: 'index'
  end
  def create
    @type = Type.create(type_params)
    if @type.save
      redirect_to types_path, notice: "#{@type.title} has been save"
    #  redirect_to action: 'index'
    else
      render 'new'
    end
  end
  def search
    @type = Type.where("title LIKE ?", "%#{params[:form][:search]}%") #where เพื่อระบุเงื่อนไขของ sql
    @search = params[:form][:search]
    render 'index'

  end
  private
    def type_params
      params.require(:type).permit(:title, :detail)
    end
end

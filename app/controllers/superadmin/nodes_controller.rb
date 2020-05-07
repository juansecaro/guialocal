class Superadmin::NodesController < Superadmin::ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  def index
    @nodes = Node.all # order?
  end

  def new
    @node = Node.new
  end

  def create
    @node = Node.new(node_params)
    if @node.save
      redirect_to superadmin_nodes_path, notice: 'El nodo se ha creado con éxito' 
    else
      render :new
      flash.now[:alert] = 'Nodo no creado'
    end
  end

  def show
    # code
  end

  def edit
    # code
  end

  def update
    if @node.update(node_params)
      redirect_to superadmin_nodes_path, notice: 'El nodo se ha actualizado con éxito'
    else
      render :edit
      flash.now[:alert] = 'Nodo no actualizado'
    end
  end

  def destroy
    @node.destroy
    redirect_to superadmin_nodes_path, notice: 'Nodo eliminado.'
  end

  private
  def set_node
    @node = Node.find(params[:id])
  end
  def node_params
    params.require(:node).permit(:number, :address, :description)
  end
end

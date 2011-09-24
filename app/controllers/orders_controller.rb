class OrdersController < ApplicationController

  load_and_authorize_resource

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @orders }
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    #load_and_authorize_resource will do the following
    #@order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    #load_and_authorize_resource will do the following
    #@order = Order.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orders/1/edit
  def edit
    #load_and_authorize_resource will do the following
    #@order = Order.find(params[:id])
  end

  # POST /orders
  # POST /orders.json
  def create
    #load_and_authorize_resource will do the following
    #@order = Order.new(params[:order])
    @order.user = current_user
    
    if @order.buckets.empty?
       bucket = Bucket.create(:gap => 0, :lastPrice => 0)
       @order.bucket_ids = [bucket.id]
    end

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: "new" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end

    #i should move this later for sure because what if order.save is unsuccessful
    @order.buckets.each { |b| b.match }
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    #load_and_authorize_resource will do the following
    #@order = Order.find(params[:id])

    params[:order][:bucket_ids] ||= []

    preUpdateBuckets = @order.buckets.map{|b| b.id}

    respond_to do |format|
      if @order.update_attributes(params[:order])
        pstUpdateBuckets = @order.buckets.map{|b| b.id}
        difBuckets = preUpdateBuckets - pstUpdateBuckets
        for bucketIds in (difBuckets)
          bucket = Bucket.find(bucketIds);
          if bucket.orders.empty?
            bucket.destroy
          end
        end
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    #load_and_authorize_resource will do the following
    #@order = Order.find(params[:id])
    preDeleteBuckets = @order.buckets.map{|b| b.id}
    @order.destroy
    for bucketIds in (preDeleteBuckets)
      bucket = Bucket.find(bucketIds);
      if bucket.orders.empty?
        bucket.destroy
      end
    end
 
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :ok }
    end
  end
end

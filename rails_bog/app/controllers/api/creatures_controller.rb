class Api::CreaturesController < ApplicationController
  def index
    @creatures = Creature.all
    render json: @creatures
  end

  def show
    # get the creature id from the url params
    creature_id = params[:id]
          
    # use `creature_id` to find the creature in the database
    # and save it to an instance variable
    @creature = Creature.find_by_id(creature_id)
          
    render json: @creature
  end

  def create
    # create a new creature from `creature_params`
    @creature = Creature.new(creature_params)
     
    # if creature saves, render the new creature in JSON
    if @creature.save
      render json: @creature
    end
  end

  def update
    # get the creature id from the url params
    creature_id = params[:id]
    
    # use `creature_id` to find the creature in the database
    # and save it to an instance variable
    @creature = Creature.find_by_id(creature_id)
    
    # update the creature
    @creature.update_attributes(creature_params)  # this now calls the private method below!
    
    render json: @creature
  end

  def destroy
    # get the creature id from the url params
    creature_id = params[:id]
    
    # use `creature_id` to find the creature in the database
    # and save it to a variable
    @creature = Creature.find_by_id(creature_id)

    # destroy the creature
    @creature.destroy

    render json: {
      msg: "Successfully Deleted"
    }
  end

  private

  def creature_params
    params.require(:creature).permit(:name, :description) 
  end
end

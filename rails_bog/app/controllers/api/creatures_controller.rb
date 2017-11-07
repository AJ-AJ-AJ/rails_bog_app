class Api::CreaturesController < ApplicationController
  def index
    @creatures = Creature.all
    render json: @creatures
  end
end

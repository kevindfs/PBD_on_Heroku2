class WelcomeController < ApplicationController
  def reserva
  end

  def qs
  	@owners= Owner.all
  end

  def tarifas
    @fixed_rates = FixedRate.all

  end

  def contacto
  end
end

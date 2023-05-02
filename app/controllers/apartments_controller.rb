class ApartmentsController < ApplicationController

    def index
        apartments = Apartment.all 
        render json: apartments
    end

    def show
        apartment = find_apartment
        if apartment
            render json: apartment
        else
            render json: { error: 'Apartment not found'}, status: :not_found
        end
    end

    def create
        apartment = Apartment.create(apartment_params)
        if apartment.valid?
            render json: apartment, status: :created
        else
            render json: { errors: apartment.errors}, status: :unprocessable_entity
        end
    end

    def update
        apartment = Apartment.find(params[:id])
        apartment.update(apartment_params)
        if apartment.valid?
            render json: apartment
        else
            render json: { errors: apartment.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        apartment = find_apartment
        if apartment
            apartment.destroy
            head :no_content
        else
            render json: { error: 'Apartment not found'}, status: :not_found
        end
    end

    private

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find_by(id: params[:id])
    end
end

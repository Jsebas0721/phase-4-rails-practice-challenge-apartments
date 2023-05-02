class TenantsController < ApplicationController
    def index
        tenants = Tenant.all 
        render json: tenants
    end

    def show
        tenant = find_tenant
        if tenant
            render json: tenant
        else
            render json: { error: 'tenant not found'}, status: :not_found
        end
    end

    def create
        tenant = Tenant.create(tenant_params)
        if tenant.valid?
            render json: tenant, status: :created
        else
            render json: { errors: tenant.errors}, status: :unprocessable_entity
        end
    end

    def update
        tenant = Tenant.find(params[:id])
        tenant.update(tenant_params)
        if tenant.valid?
            render json: tenant
        else
            render json: { errors: tenant.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        tenant = find_tenant
        if tenant
            tenant.destroy
            head :no_content
        else
            render json: { error: 'tenant not found'}, status: :not_found
        end
    end

    private

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find_by(id: params[:id])
    end
end

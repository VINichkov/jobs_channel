class PropertiesController < InheritedResources::Base

  private

    def property_params
      params.require(:property).permit(:code, :value, :description)
    end

end

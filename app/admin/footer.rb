module ActiveAdmin
  module Views
    class Footer < Component
      def build(attributes = {})
        super :id => "footer"
        super :class=> "footer navbar navbar-expand-lg navbar-dark bg-dark"

        div do
          small "Cool footer #{Date.today.year}"
        end
      end

      def tag_name
        'footer'
      end
    end
  end
end
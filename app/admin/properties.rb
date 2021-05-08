ActiveAdmin.register Property do
  permit_params :code, :value, :description

  index do
    selectable_column
    id_column
    column :code
    column :value
    column :description
  end

  filter :code
  filter :value
  filter :description

  form do |f|
    f.inputs do
      f.input :code
      f.input :value
      f.input :description
    end
    f.actions
  end

end
class ProductsIndex < Chewy::Index
  define_type Product do
    field :name
    field :reviews do
      field :text
    end
  end
end

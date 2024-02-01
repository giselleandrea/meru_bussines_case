require "test_helper"

class Api::V1::ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get products" do
    get api_v1_products_url
    assert_response :success
  end

  test "should create product" do
    product_params = {
      name: "Nuevo Producto",
      description: "Descripción del nuevo producto",
      price: 19.99,
      quantity: 10
    }

    post api_v1_new_product_url, params: { product: product_params }
    assert_response :created

    assert_equal "Producto creado con éxito", JSON.parse(response.body)["message"]
  end

end

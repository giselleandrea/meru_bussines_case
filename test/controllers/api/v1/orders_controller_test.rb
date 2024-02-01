require "test_helper"

class Api::V1::OrdersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "should get orders" do
    get api_v1_orders_url
    assert_response :success
    assert JSON.parse(response.body).key?("orders")
  end

  test "should create order" do
    user = users(:one)
    order_params = {
      order: {
        order_has_products_attributes: [
          { product_id: products(:one).id, cant: 2 },
          { product_id: products(:two).id, cant: 1 }
        ]
      }
    }

    token = JsonWebToken.encode(user_id: user.id)
    headers = { 'Authorization' => "Bearer #{token}" }

    post api_v1_new_order_url, params: order_params, headers: headers
    assert_response :created

    assert_equal "Orden creada con éxito", JSON.parse(response.body)["message"]
  end
end

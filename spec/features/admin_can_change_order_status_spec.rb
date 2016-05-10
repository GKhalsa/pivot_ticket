# require "rails_helper"
#
# RSpec.feature "Admin can change status of an order" do
#   scenario "admin can see total orders for each status" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#
#     create(:order)
#
#     click_link("Orders")
#
#     within(".all-tab") do
#       expect(page).to have_content("All")
#       expect(page).to have_content("1")
#     end
#     within(".ordered-tab") do
#       expect(page).to have_content("Ordered")
#       expect(page).to have_content("1")
#     end
#     within(".paid-tab") do
#       expect(page).to have_content("Paid")
#       expect(page).to have_content("0")
#     end
#     within(".completed-tab") do
#       expect(page).to have_content("Completed")
#       expect(page).to have_content("0")
#     end
#     within(".cancelled-tab") do
#       expect(page).to have_content("Cancelled")
#       expect(page).to have_content("0")
#     end
#   end
#
#   scenario "admin can filter orders by each status" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#
#     order = create(:order)
#     click_link("Orders")
#
#     within(".ordered-tab") do
#       click_link("Ordered")
#     end
#
#     expect(page).to have_content(order.id)
#     expect(page).to have_content(order.updated_time)
#   end
#
#   scenario "admin can mark an ordered order as paid" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     visit admin_dashboard_path
#
#     order = create(:order)
#     click_link("Orders")
#
#     expect(order.status).to eq ("ordered")
#     within("#all") do
#       click_link("Mark as Paid")
#     end
#     order = Order.last
#
#     expect(order.status).to eq("paid")
#   end
#
#   scenario "admin can mark a paid order as completed" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     order = create(:paid_order)
#
#     visit admin_dashboard_path
#     click_link("Orders")
#
#     expect(order.status).to eq ("paid")
#
#     within("#all") do
#       click_link("Mark as Completed")
#     end
#     order = Order.last
#
#     expect(order.status).to eq("completed")
#     ActionMailer::Base.deliveries.clear
#   end
#
#   scenario "admin can cancel an order that is paid" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     order = create(:paid_order)
#
#     visit admin_dashboard_path
#     click_link("Orders")
#
#     expect(order.status).to eq ("paid")
#     within("#all") do
#       click_link "cancel order"
#     end
#
#     order = Order.last
#     expect(order.status).to eq ("cancelled")
#   end
#
#   scenario "admin can cancel an order that is ordered" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     order = create(:order)
#
#     visit admin_dashboard_path
#     click_link("Orders")
#
#     expect(order.status).to eq ("ordered")
#     within("#all") do
#       click_link "cancel order"
#     end
#
#     order = Order.last
#     expect(order.status).to eq ("cancelled")
#   end
#
#   scenario "admin can send email by changing status to completed" do
#     admin = create(:admin)
#
#     ApplicationController.any_instance.stubs(:current_user).returns(admin)
#
#     create(:paid_order)
#
#     visit admin_dashboard_path
#     click_link("Orders")
#
#     within("#all") do
#       click_link("Mark as Completed")
#     end
#     expect(ActionMailer::Base.deliveries.count).to eq 1
#     ActionMailer::Base.deliveries.clear
#   end
# end

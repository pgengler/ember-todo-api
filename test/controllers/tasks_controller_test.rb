require 'test_helper'

class TasksControllerTest < ActionController::TestCase
	test "should get index" do
		get :index
		assert_response :success
	end

	test "index view includes appropriate tasks" do
		get :index
		body = JSON.parse(response.body)
		assert_equal Task.count, body['tasks'].length
	end

	test "can create new tasks" do
		assert_difference 'Task.count' do
			post :create, task: {day_id: days(:october_1), description: "New task"}
		end
	end

	test "all values are assigned to newly-created tasks" do
		new_task_params = {day_id: days(:october_1), description: "New task"}
		post :create, task: new_task_params
		task = assigns(:task)
		assert_equal new_task_params[:description], task.description
    assert_equal days(:october_1), task.day
	end

	test "create action returns 'created' HTTP status code after creating task" do
		new_task_params = {day_id: days(:october_1), description: "New task"}
		post :create, task: new_task_params
		assert_response :created
	end

	test "returns data for a single task" do
		get :show, id: tasks(:incomplete)
		assert_response :success
		body = JSON.parse(response.body)
		assert_equal body['task']['id'], tasks(:incomplete).id
	end

	test "updates the 'done' property" do
		task = tasks(:incomplete)
		post :update, id: task, task: { done: true }
		assert_response :success
		assert_equal true, assigns(:task).done
	end
end
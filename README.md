Ruby on rails ships with Minitest - Testing Framework
There are other popular ones like RSpec
 
Types of testing

Integration testing (testing Entire feature)
Model Tests - Unit testing (testing small functionality)

1. Build the homepage of the application which will be the layout of the application.
We will create an integration test that essentially goes out there (home page) and looks for the route that we provided and ensures that gets a success from the response of that route.

Command:

rails g integration_test pages

integration_test is the keyword.

assert that we get a response from the homepage. 

Sample tests
  test "should get home" do 
    get pages_home_url
    assert_response :success
  end

  test "should get root" do 
    get root_url
    assert_response :success
  end

To run,
Command:

rails test

Response:

E

Error:
PagesTest#test_should_get_home:
NameError: undefined local variable or method `pages_home_url' for #<PagesTest:0x007ffbc6a08b00>
    test/integration/pages_test.rb:9:in `block in <class:PagesTest>'

E

Error:
PagesTest#test_should_get_root:
NameError: undefined local variable or method `root_url' for #<PagesTest:0x007ffbc2e84098>
    test/integration/pages_test.rb:14:in `block in <class:PagesTest>'

The above errors are because we haven't built anything like root_url or home url i.e., pages_home_url

This is TDD(Test Driven Development). We are writing out the tests first and building out the functionality after that. 

TDD - design the app functionality based on a test first approach
Write the test for the functionality
Build minimum code necessary to make each test pass.

Re-factor the code so that your code doesn't smell. So you have the clean code and also you will make sure that you will re-factor the code without breaking the functionality. This is automatically taken care of by the testing framework. (confidence).

Now add routes in the routes.rb

  root 'pages#home'
  get 'pages/home', to: 'pages#home'

Now lets run our test 

rails test

So now, this is the error

# Running:

E

Error:
PagesTest#test_should_get_root:
ActionController::RoutingError: uninitialized constant PagesController
    test/integration/pages_test.rb:14:in `block in <class:PagesTest>'


bin/rails test test/integration/pages_test.rb:13

E

Error:
PagesTest#test_should_get_home:
NameError: undefined local variable or method `pages_home_url' for #<PagesTest:0x007ffbc691ad38>
    test/integration/pages_test.rb:9:in `block in <class:PagesTest>'

Meaning we dont have a pages controller

So, now its time to build a controller. 
Create a new file in app/controllers/ and call it as pages_controller.rb

class PagesController < ApplicationController
end

Let's run our test again.

rails test

Now we have the same error message for both the tests. i.e., The action 'home' could not be found.

# Running:

E

Error:
PagesTest#test_should_get_home:
AbstractController::ActionNotFound: The action 'home' could not be found for PagesController
    test/integration/pages_test.rb:9:in `block in <class:PagesTest>'


bin/rails test test/integration/pages_test.rb:8

E

Error:
PagesTest#test_should_get_root:
AbstractController::ActionNotFound: The action 'home' could not be found for PagesController
    test/integration/pages_test.rb:14:in `block in <class:PagesTest>'

So lets define the home action in the pages_controller.rb

def home
end

Let's run our test again.

rails test

Now it says it couldn't find a view.

# Running:

E

Error:
PagesTest#test_should_get_root:
ActionController::UnknownFormat: PagesController#home is missing a template for this request format and variant.

request.formats: ["text/html"]
request.variant: []

NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
    test/integration/pages_test.rb:14:in `block in <class:PagesTest>'


bin/rails test test/integration/pages_test.rb:13

E

Error:
PagesTest#test_should_get_home:
ActionController::UnknownFormat: PagesController#home is missing a template for this request format and variant.

request.formats: ["text/html"]
request.variant: []

NOTE! For XHR/Ajax or API requests, this action would normally respond with 204 No Content: an empty white screen. Since you're loading it in a web browser, we assume that you expected to actually render a template, not nothing, so we're showing an error to be extra-clear. If you expect 204 No Content, carry on. That's what you'll get from an XHR or API request. Give it a shot.
    test/integration/pages_test.rb:9:in `block in <class:PagesTest>'

So lets go ahead and add the template. Under app/views/
create a folder called pages and under pages folder add a new view file. Call it home.html.erb

Now lets run it again.

rails test


You should get a success message like this


# Running:

..

Finished in 3.688545s, 0.5422 runs/s, 0.5422 assertions/s.

2 runs, 2 assertions, 0 failures, 0 errors, 0 skips

Our tests are passed!!!

Now start your server and visit the homepage http://localhost:3000/ 
also you can type in
http://localhost:3000/pages/home
and see it works perfect.



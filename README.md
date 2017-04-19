Generic Notes:
https://docs.google.com/document/d/1Jb59T1OX1yGGWsxP7McDNLnpo668qF-fVhJvLiJQmkk/edit?ts=58f70741

Install bootstrap

http://getbootstrap.com/getting-started/#examples

Here you get a lot of templates
Lets use a simple layout like jumbotron for now

Ruby on rails gem for bootstrap

https://github.com/twbs/bootstrap-sass

Put this line in the Gemfile
gem 'bootstrap-sass', '~> 3.3.6'

then
bundle install

What is Asset pipeline?
The asset pipeline provides a framework to concatenate and minify or compress JavaScript and CSS assets. It also adds the ability to write these assets in other languages and pre-processors such as CoffeeScript, Sass and ERB. It allows assets in your application to be automatically combined with assets from other gems. For example, jquery-rails includes a copy of jquery.js and enables AJAX features in Rails.

Any javascript file which you create will be served through application.js(application.js is also called as Manifest file) to your application.

In views/layouts/application.html.erb, you will find a line
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
what it is saying is include all the js made available in this application.js

So we have to add a line in application.js to make bootstrap available. Add it right under jquery_ujs
Something like this
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require turbolinks
//= require_tree .

Similarly stylesheets, ie., application.css file is the manifest file for your css. 
All the css which you will create will be served through this file.

In views/layouts/application.html.erb, you will find a line
    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
what it is saying is Make all the styling available to all of the views that we have through this file(i.e., application.css file)

In this case unlike application.js we are not gonna make any changes to the application.css as you can see (*= require_tree .) in the first line.

require_self tell the asset pipeline to include the file within which it is used i,e here it is telling the asset pipeline to include application.css file also while precompiling the css assets . It means if you write any css within application.css (avoid it , it is against convention) that will also get reflected.basically, since we are not writing any css within application.css, removing require_self will not make any difference.

require_tree will tell asset pipeline to include all the files within the specified directory. By default it is set to current directory with . (i,e dot) . So say you have bootstrap.min.css and bootstrap_responsive.min.css file in app/assets/stylesheet folder, then the require_tree . will automatically load them. Now say you have put your all custom css file in app/assets/custom_css folder, then you can load them by writing another require_tree as below

So we are gonna create a new file in app/assets/stylesheets/custom.css.scss

.scss sass css You can type in sass code. It makes css more easier and adding additional new things

In custom.css.scss add the below 2 lines:
@import "bootstrap-sprockets";
@import "bootstrap";

Thats all... with that bootstrap is installed and configured.










# Ruby On Rails multiple files by Pete

An agile way to implement multiple files uploads in Ruby On Rails scaffold without the need to create additional tables


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multiple_files_by_pete'
```

And then execute:

    $ bundle install

## Support

Ruby On Rails: 5, 6, 7

This gem does not work with SQLite database

## Usage
Let's create a example for a Place scaffold:

1. Let's create a new rails app:

```ruby
rails new myapp --database=postgresql
```

2. Create the database:

```ruby
bundle exec rake db:create
```

3. Go to your application's directory in Terminal and run the command:

```ruby
bundle exec rails g scaffold Place name:string description:text
```

4. Add this line to your application's Gemfile:

```ruby
gem 'multiple_files_by_pete'
```

5. Go to your application's directory in Terminal and run:

```ruby
bundle install
```

6. Go to your application's directory in Terminal and run the installation command for mutiple_files_by_pete:

```ruby
bundle exec rake 'multiple_files_by_pete[place]'
```

7. Add jQuery to your layout file:

```html
<script src='/multiple_files_by_pete/jquery-3.6.0.min.js'></script>
```

8. Add bootstrap.min.css to your layout file:

```html
<link rel="stylesheet" href="/multiple_files_by_pete/bootstrap.min.css">
```

9. Copy and paste this code to get all the object files. For this example paste it in the edit action of the places_controller.rb file

```ruby
@files = PeteFile.get_object_files(@place)
```

10. Copy paste this code for each file field you need, you can add as many as you want by changing the section variable. For this example paste it into the /places/_form.html.erb file:

```ruby

<%= render partial: 'shared/files_by_pete', locals: {model: @place, files: @files, section: 'legal_files' ,label: 'Upload legal files'}  %>

<%= render partial: 'shared/files_by_pete', locals: {model: @place, files: @files, section: 'extra_files' ,label: 'Upload extra files'}  %>

```

11. Copy and paste this code at the end of the form where you have added the file fields. The size limit is in MB. For this example paste it in the file /places/_form.html.erb:

```ruby
<%= render 'shared/files_by_pete_js', model: @place, size_limit: 50%>
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/peterconsuegra/multiple_files_by_pete. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/peterconsuegra/multiple_files_by_pete/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the MultipleFilesByPete project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/peterconsuegra/multiple_files_by_pete/blob/master/CODE_OF_CONDUCT.md).

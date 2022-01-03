# Multiple Files By Pete

An agile way to implement multiple files uploads in ruby on rails scaffold, without the need to create additional tables


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

1. rails new myapp --database=postgresql

```ruby
rails new myapp --database=postgresql
```

2. Go to your application's directory in Terminal and run the command:

```ruby
bundle exec rails g scaffold Place name:string description:text
```

3. Add this line to your application's Gemfile:

```ruby
gem 'multiple_files_by_pete'
```

4. Go to your application's directory in Terminal and run:

```ruby
bundle install
```

5. Go to your application's directory in Terminal and run the installation command for mutiple_files_by_pete:

```ruby
bundle exec rake 'multiple_files_by_pete[place]'
```

6. Add jQuery to your layout file:

```html
<script src='/multiple_files_by_pete/jquery-3.6.0.min.js'></script>
```

7. Add bootstrap.min.css to your layout file:

```html
<link rel="stylesheet" href="/multiple_files_by_pete/bootstrap.min.css">
```

8. Get all the files of that model in the action of the controller you are want:

```ruby
@files = PeteFile.get_object_files(@place)
```

9. Add the number of fields to upload files you need to your _form.html.erb file:

```ruby

<%= render partial: 'shared/files_by_pete', locals: {model: @place, files: @files, section: 'legal_files' ,label: 'Upload legal files'}  %>

<%= render partial: 'shared/files_by_pete', locals: {model: @place, files: @files, section: 'extra_files' ,label: 'Upload extra files'}  %>

```

10. Add the JS logic for multiple_file_by_pete to your _form.html.erb file. The size limit is in MB:

```ruby
<%= render 'shared/files_by_pete_js', model: @place, size_limit: 50%>
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/multiple_files_by_pete. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/multiple_files_by_pete/blob/master/CODE_OF_CONDUCT.md).

## Code of Conduct

Everyone interacting in the MultipleFilesByPete project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/multiple_files_by_pete/blob/master/CODE_OF_CONDUCT.md).

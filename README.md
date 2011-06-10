FedARH
======

Federal Reserve E-Payments Routing Directory Parser

Created for Square's Ruby on Rails Software Engineer job application on 2011-06-10.
Referred by Colin Loretz at Reno Collective.

Usage
=====

```ruby
require 'fed_arh'
data = FedARH.new(<data_file||data_url>).parse
```

Example usage to load a database in Ruby on Rails
=================================================

app/models/fed_model.rb
```ruby
require 'fed_arh'
class FedModel
  include Mongoid::Document
  include Mongoid::Timestamps
end
```

```ruby
# if model field names matches the gem field names
def load_data_into_database
  data.each do |d|
    FedModel.create(d)
  end
end
```

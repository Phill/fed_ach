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

Example usage to load a database in Ruby on Rails using MongoDB and
Mongoid
=================================================

Setup your models like this:

```ruby
class FedModel
  include Mongoid::Document
  include Mongoid::Timestamps
  field :routing_number
  field :office_code
  field :servicing_fbr
  field :record_type
  field :change_date
  field :new_routing_number
  field :customer_name
  field :address
  field :city
  field :state
  field :zip
  field :zip_ext
  field :phone_area_code
  field :phone_prefix
  field :phone_suffix
  field :institution_status
  field :data_view_code
  field :filler
end
```

Resque RunImport task for background processing:

```ruby
require 'fed_arh'
class RunImport
  def self.perform(data_file = nil)
    return false if data_file.nil?
    load_data_info_database(data_file)
  end

  def load_data_into_database(data_file)
    data = FedARH.new(data_file).parse
    data.each do |d|
      FedModel.create(d)
    end
  end
end
```

Setup your controller like this:

```ruby
class Import < ApplicationController
  respond_to :html

  def index
  end

  def new
  end

  def create
    Resque.enqueue(RunImport, params[:import][:feed_file].read)
    flash[:notice] = 'Import running in background.'
    redirect_to import_index_path
  end
end
```

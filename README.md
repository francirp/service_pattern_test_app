# Service Pattern

## Basic Idea

When implementing a Rails API backend, we don't really need a controller. This is because most of our routes should be RESTful, and therefore follow a predictable pattern.

For a given resource...
- Collect: list items
- Create: create new item
- Show: show item
- Update: update item
- Destroy: delete item

Many of these actions have shared behavior:
- All require serialization of the resource
- Create and Update need to be able to properly respond with error information when save does not succeed
- Create and Update rely on decanted params
- Authorization technique (cancancan)

## Example

Given an Event model, one can do the following and get a basic RESTful API:

- rails g model Event name:string start_date:date
- rails g decanter Event name:string start_date:date
- rails g serializer Event name:string start_date:date
- add the new resource in routes

With that, you have the following at your disposal:

Collect: get '/events'
Create: post '/events'
Show: get '/events/:id'
Update: put '/events/:id'
Destroy: delete '/events/:id'

Each of these will respond with a consistent JSON format, including when saves don't succeed.

## Overriding Default Services

Should you choose to override the default behavior (defined in app/services/defaults/, ), you need only create your own service like so:

app/services/events/collect.rb

```
module Events
  class Collect < CollectService
    def collection
      Event.all.limit(10)
    end
  end
end
```

app/services/events/create.rb

```
module Events
  class Create < CreateService
    def create
      Event.create(model_params)
    end
  end
end
```

app/services/events/show.rb

```
module Events
  class Show < ShowService
    def object
      Event.find(params[:id])
    end
  end
end
```

app/services/events/update.rb

```
module Events
  class Update < UpdateService
    def updated_object
      event = Event.find(params[:id])
      event.update(model_params)
      event
    end
  end
end
```

app/services/events/destroy.rb

```
module Events
  class Destroy < DestroyService
    def destroyed_object
      event = Event.find(params[:id])
      event.destroy
      event
    end
  end
end
```

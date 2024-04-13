# Authentication
### Sign in 
```gdscript
[gdscript style]

func sign_in():
  Supabase.auth.signed_in.connect(_on_signed_in)
  Supabase.auth.sign_in(user_mail, user_pwd)

func _on_signed_in(user : SupabaseUser):
  print("Successfully signed as ", user)
```
or
```gdscript
[javascript style]

func sign_in():
  var signtask : AuthTask = yield(Supabase.auth.sign_in(user_mail, user_pwd), "completed")
  if signtask.error == null:
     print("Successfully signed as ", signtask.user)
     print(signtask.data)
```

<br/>

# Database  
### Select query  
```gdscript
[gdscript style]

func select():
  Supabase.database.connect("selected", self, "_on_selected")
  var query = SupabaseQuery.new().from("test-table").select().In("name", ["Test"])
  Supabase.database.query(query)

func _on_selected(result : Array):
    print(result)
```
or
```gdscript
[javascript style]

func select():
  var query = SupabaseQuery.new().from("test-table").select().In("name", ["Test"])
  var dbtask : DatabaseTask = yield(Supabase.database.query(query), "completed")
  if dbtask.error == null:
     print(dbtask.data)
```

<br/>

### Full Text Search
```gdscript
[javascript style]

var query = SupabaseQuery.new().from("books").text_seach("description", "other", "plain", "english").select(["author, title"])
var task : DatabaseTask = yield(Supabase.database.query(query), "completed")
print(task.data, " ", task.error)
```

<br/>

### RPC Call
```gdscript
[javascript style]

var task : DatabaseTask = yield(Supabase.database.rpc("increment_value", {row_id = 1}), "completed")
print(task.data, " ", task.error)

# RPC call with query
var task : DatabaseTask = yield(Supabase.database.rpc("increment_value", {row_id = 1}, SupabaseQuery.new().select(["id", "name"]), "completed")
print(task.data, " ", task.error)
```

<br/>


# Realtime
### Insert events
```gdscript
var client : RealtimeClient

func get_insert():
  client = Supabase.realtime.client()
  client.connect("connected", self, "_on_connected")
  client.connect_client()
  
func _on_connected():
  var channel : RealtimeChannel = client.channel("public", "test-table").connect("insert", self, "_on_insert").subscribe()

func _on_insert(new_record : Dictionary, channel : RealtimeChannel):
    print("New Record inserted ", json_parse(new_record), " on ", channel.topic)
```

<br/>

# Storage
### Create a bucket and upload a file
```gdscript
var task : StorageTask = yield(Supabase.storage.create_bucket("new_bucket", "new_bucket"), "completed")
print("data: ",task.data, " || error: ", task.error)
var upload : StorageTask = yield(Supabase.storage.from(task.data.name).upload("files/file.txt", "res://file.txt"), "completed")
```
or
```gdscript
func create_bucket() -> void:
    Supabase.storage.connect("created_bucket", self, "_on_bucket_created")
    Supabase.storage.create_bucket("another_bucket", "another_bucket")
    
func _on_bucket_created(bucket : StorageBucket) -> void:
    var upload : StorageTask = yield(bucket.upload("files/file.txt", "res://file.txt"), "completed")
```
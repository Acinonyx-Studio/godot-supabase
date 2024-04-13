Here you can find the complete list of APIs currenlty implemented with GDScript

|Table of contents| Auth | Database | Realtime | Storage |  
|---------|-------------------------------------- | -------------------------------------- | -------------------------------------- | -------------------------------------- |
| APIs    | [SupabaseAuthentication](#supabaseauthentication-supabaseauth) | [SupabaseDatabase](#supabasedatabase-supabasedatabase)| [SupabaseRealtime](#supabaserealtime-supabaserealtime)| none|
| Classes | [SupabaseAuthTask]()<br/>[SupabaseAuthError]()<br/>[SupabaseUser]()  | [SupabaseDatabaseTask]()<br/>[SupabaseDatabaseError]()<br/>[SupabaseQuery]()  | [RealtimeClient]()<br/>[RealtimeChannel]()<br/>| none|


<br/>  

<br/>

# APIs
### SupabaseAuthentication (`Supabase.auth`)
| Method       | Return | Description                                                                              |
|--------------|------------------------------------------------------------------------------------------| -- |
| `sign_up(email : String, password : String)` | `AuthTask` | Allow a user to sign up and create a new account.        |              
| `sign_in(email : String, password : String)` | `AuthTask`  | Allow a user to sign in with email/password combination. |             
| `sign_in_with_provider(provider : String)` | `void`  | Allow a user to sign in with a provider (SupabaseAuth.Providers). |  
| `sign_out()` | `AuthTask`  | Allow a user to sign out. |  
| `send_magic_link(email : String)` | `AuthTask`  | Allow a user to sign in using a magic link. |  
| `update(email : String, password : String, data : Dictionary = {})` | `AuthTask`  | Allow a user to update personal information/metadata. |  
| `reset_password_for_email(email : String, password : String)` | `AuthTask`  | Allow a user to reset the password requesting a reset email. |  
| `invite_user_by_email(email : String)` | `AuthTask`  | Allow a user to invite another user using user's email. |  
| `user(user_access_token : String)` | `AuthTask` | Retrieve user's information.                                       |   

*Some examples on how to use Authentication methods [here]().*

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `signed_up(user : SupabaseUser)` | Emitted when a user has correctly signed up. Returns user's information.             |
| `signed_in(user : SupabaseUser)` | Emitted when a user has correctly signed in. Returns user's information.             |
| `got_user(user : SupabaseUser)`  | Emitted when a user has been correctly retrieved. Returns user's information.        |
| `logget_out()`    |   |  
| `user_updated(updated_user : SupabaseUser)`    |  |  
| `magic_link_sent()`    |  |  
| `reset_email_sent()`    |   |  
| `user_invited()`    |    |  
| `error(error: SupabaseError)`    | Emitted when a request was not processed correctly. Returns the error with details.  |  

*Some examples on how to use Authentication signals [here]().*  
  
<br/>  

### SupabaseDatabase (`Supabase.database`)
| Method       | Return | Description                                                           |
|------------------------------------------| --- | ---------------------------------------------------|
| `query(supabase_query : SupabaseQuery)` | DatabaseTask | Issue a query on Supabase Database.        |
| `rpc(function_name : String, arguments : Dictionary = {}, supabase_query : SupabaseQuery = null)` | DatabaseTask | Call an function through RPC to your Database.        |     

*Some examples on how to use Database methods [here]().*

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `selected(result : Array)`    | Emitted when a query has been correctly issued. Returns query's result.                 |
| `inserted(result : Array)`                  | Emitted when an INSERT query has been correctly issued.                                 |
| `updated(result : Array)`                   | Emitted when an UPDATE query has been correctly issued.                                 |
| `deleted(result : Array)`                   | Emitted when a DELETE query has been correctly issued.                                  |
| `error(error: SupabaseError)` | Emitted when a query has not been processed correctly. Returns the error with details.  |  

*Some examples on how to use Database signals [here]().*  
  
<br/>  

### SupabaseRealtime (`Supabase.realtime`)
| Method       | Return | Description                                                           |
|--------------|-----------------------------------------------------------------------| ---- |
| `client(supabase_url : String = default, supabase_apikey = default)` | `RealtimeClient` | Get a RealtimeClient.        |   

*Some examples on how to use Realtime methods [here]().*

<br/>

<br/>

# Classes
### SupabaseError (`SupabaseAuthError`)
| Property      | Type   | Description                                                           |
|---------------|--------|-----------------------------------------------------------------------|
| `type`        |`String`| The type of the error, can be a code or the error's name.             |            
| `description` |`String`| The description or the message of the error.                          |

*Some examples on how to use SupabaseAuthError [here]().*

<br/>  
  
### SupabaseError (`SupabaseDatabaseError`)
| Property      | Type   | Description                                                           |
|---------------|--------|-----------------------------------------------------------------------|
| `code`        |`String`| The type of the error, can be a code or the error's name.             |            
| `message`     |`String`| The description or the message of the error.                          |
| `hint`        |`String`| The description or the message of the error.                          |
| `details`     |`String`| The description or the message of the error.                          |

*Some examples on how to use SupabaseDatabaseError [here]().*

<br/>  

### SupabaseAuthTask (`AuthTask`)
| Property      | Type   | Description                                                           |
|---------------|--------|-----------------------------------------------------------------------|
| `error`        |`SupabaseAuthError`| The error related to this task, if failed.             |            
| `user`     |`SupabaseUser`| The user owning this task.                          |
| `data`        |`Dictionary`| The data of this task, if successful.                          |

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `completed(task : (self))` | Emitted when the task has been completed. Whis signal will return the task itself, allowing you to get `error` or `data`.             |

*Some examples on how to use AuthTask signals [here]().*  

<br/>

### SupabaseDatabaseTask (`DatabaseTask`)
| Property      | Type   | Description                                                           |
|---------------|--------|-----------------------------------------------------------------------|
| `error`        |`SupabaseAuthError`| The error related to this task, if failed.             |            
| `data`        |`Array`| The data of this task, if successful.                          |

*Some examples on how to use AuthTask [here]().*

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `completed(task : (self))` | Emitted when the task has been completed. Whis signal will return the task itself, allowing you to get `error` or `data`.             |

*Some examples on how to use DatabaseTask signals [here]().*  

<br/>

### SupabaseRealtimeClient (`RealtimeClient`)
| Property           | Type   | Description                                        |
|--------------------|--------|----------------------------------------------------|
| `channels`            |`Array`    | All joined and left channels.                |  

<br/>

| Method       | Return | Description                                                           |
|--------------|-----------------------------------------------------------------------| ---- |
| `new(supabase_url : String = default, supabase_apikey = default, timeout : float)` | `RealtimeClient` | Get a RealtimeClient.        |  
| `connect_client()` | `int` | Connect the current RealtimeClient.        |  
| `disconnect()` | `int` | Disconnect the current RealtimeClient.        |   
| `channel(schema : String, table : String = "", col_value : String = "")` | `RealtimeChannel` | Get a `RealtimeChannel` building a topic from a `schema:table:col_value` string.        |  

*Some examples on how to use RealtimeClient methods [here]().*

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `connected()`                  | Emitted when the RealtimeClient is successfully connected.                                 |
| `disconnected()`                   | Emitted when a RealtimeClient gets disconnected.                                 |
| `error(message)`                   | Emitted when there's an Error.                                  |

*Some examples on how to use Realtime signals [here]().*  

<br/>

### SupabaseRealtimeChannel (`RealtimeChannel`)
| Property           | Type   | Description                                        |
|--------------------|--------|----------------------------------------------------|
| `topic`            |`String`    | The topic of this channel as a String.         |  

<br/>

| Method       | Return | Description                                                           |
|--------------|-----------------------------------------------------------------------| ---- |
| `connect(event : String , to : Node, function : String)` | `RealtimeChannel` | Connect a `SupabaseEvent` to a function to get realtime updates.        |  
| `on(event : String , to : Node, function : String)` | `RealtimeChannel` | Connect a `SupabaseEvent` to a function to get realtime updates.        |  
| `subscribe()` | `RealtimeChannel` | Subscribe to this channel to receive events with connected signals.     |   
| `unsubscribe()` | `RealtimeChannel` | Unsubscribe from this channel to stop receiving events from this channel.        |  

*Some examples on how to use RealtimeChannel methods [here]().*

<br/>  

| Signal       | Description                                                                                              |
|--------------|----------------------------------------------------------------------------------------------------------|
| `delete(old_record : Dictionary, channel : RealtimeChannel)`    | Emitted when the a `DELETE` event is received on this channel.     |
| `insert(new_record : Dictionary, channel : RealtimeChannel)`    | Emitted when the a `INSERT` event is received on this channel.     |  
| `update(old_record : Dictionary, new_record : Dictionary, channel : RealtimeChannel)`| Emitted when the a `UPDATE` event is received on this channel.|    
| `all(old_record : Dictionary, new_record : Dictionary, channel : RealtimeChannel)`| Emitted when the a `*` event is received on this channel.     |  


*Some examples on how to use RealtimeChannel signals [here]().*  

<br/>

### SupabaseUser (`SupabaseUser`)
| Property           | Type   | Description                                        |
|--------------------|--------|----------------------------------------------------|
| `email`            |`String`    | Logged user's email.                           |             
| `access_token`     |`String`    | Logged user's access token.                    |
| `token_type`       |`String`    | Logged user's token type.                      |
| `refresh_token`    |`String`    | Logged user's refresh token                    |
| `expires_in`       |`float`     | Logged user's token expiration time.           |
| `created_at`       |`String`    | Logged user's creation date.                   |
| `updated_at`       |`String`    | The description or the message of the error.   |
| `last_sign_in_at`  |`String`    | The description or the message of the error.   |
| `user`             |`Dictionary`| The description or the message of the error.   |
| `user_metadata`    |`Dictionary`| The description or the message of the error.   |
| `role`             |`String`    | The description or the message of the error.   |

*Some examples on how to use SupabaseUser [here]().*  
  
<br/>  

### SupabaseQuery (`SupabaseQuery`)
| Method       | Description                                                                              |
|--------------|------------------------------------------------------------------------------------------|
| `new()`      | Create a `SupabaseQuery` instance.        |            
| `from(table_name : String)` | |
| `select(columns : PoolStringArray = ["*"])` | |  
| `insert(fields : Array, upsert : bool = false)` | |  
| `update(feilds : Dictionary)` | |  
| `delete()` | |  
| `range(from : int, to : int)` | |  
| `order(column : String, direction : int = Directions, nullsorder : int = Nullsorder)` | |  
|`filter(column : String, filter : int, value : String)`| |  
|`match(query_dict : Dictionary)`| |
| `eq(column : String, value : String)` | |  
| `neq(column : String, value : String)` | |  
| `gt(column : String, value : String)` | |  
| `lt(column : String, value : String)` | |  
| `gte(column : String, value : String)` | |  
| `lte(column : String, value : String)` | |  
| `like(column : String, value : String)` | |  
| `ilike(column : String, value : String)` | |  
| `Is(column : String, value : String)` | |  
| `In(column : String, array : PoolStringArray)` | |  
| `Or(column : String, value : String)` | |  
| `text_seach(column : String, query : String, type : String = "", config : String = "")` ||


*Some examples on how to use SupabaseQuery methods [here]().*

<br/>  
 


<br/>  
  
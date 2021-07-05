class_name RealtimeClient
extends Node

signal connected()
signal disconnected()
signal error(message)

class PhxEvents:
    const JOIN := "phx_join"
    const REPLY := "phx_reply"
    const LEAVE := "phx_leave"
    const ERROR := "phx_error"
    const CLOSE := "phx_close"

class SupabaseEvents:
    const DELETE:= "DELETE"
    const UPDATE:= "UPDATE"
    const INSERT:= "INSERT"
    const ALL := "*"

var channels : Array = []

var _db_url : String
var _apikey : String

var _ws_client = WebSocketClient.new()
var _heartbeat_timer : Timer = Timer.new()

func _init(url : String, apikey : String, timeout : float) -> void:
    set_process(false)
    _db_url = url.replace("http","ws")+"/realtime/v1/websocket"
    _apikey = apikey
    _heartbeat_timer.set_wait_time(timeout)
    
func _ready() -> void:
    _connect_signals()
    add_child(_heartbeat_timer)

func _connect_signals() -> void:
    _ws_client.connect("connection_closed", self, "_closed")
    _ws_client.connect("connection_error", self, "_closed")
    _ws_client.connect("connection_established", self, "_connected")
    _ws_client.connect("data_received", self, "_on_data")
    _heartbeat_timer.connect("timeout", self, "_on_timeout")

func connect_client() -> int:
    var err = _ws_client.connect_to_url("{url}?apikey={apikey}".format({url = _db_url, apikey = _apikey}))
    if err != OK:
        _heartbeat_timer.stop()
    else:
        _heartbeat_timer.start()
    return err

func disconnect_client() -> void:
    pass

func _build_topic(schema : String, table : String = "", col_value : String = "") -> String:
    var topic : String = "realtime:"+schema
    if table != "":
        topic+=":"+table
        if col_value!= "":
            topic+=":"+col_value
    return topic
        
func channel(schema : String, table : String = "", col_value : String = "") -> RealtimeChannel:
    var topic : String = _build_topic(schema, table, col_value)
    var channel : RealtimeChannel = RealtimeChannel.new(topic, self)
    add_channel(channel)
    return channel

func add_channel(channel : RealtimeChannel) -> void:
    channels.append(channel)

func _closed(was_clean = false):
    emit_signal("disconnected")
    set_process(false)

func _connected(proto = ""):
    emit_signal("connected")
    set_process(true)

func _on_data() -> void:
    var data : Dictionary = get_message(_ws_client.get_peer(1).get_packet())
    #print("Got data from server: ", to_json(data))
    match data.event:
        PhxEvents.REPLY:
            if _check_response(data) == 0:
                print("Received reply = "+to_json(data))
        PhxEvents.JOIN:
            if _check_response(data) == 0:
                print("Joined topic '%s'" % data.topic)
        PhxEvents.LEAVE:
            if _check_response(data) == 0:
                print("Left topic '%s'" % data.topic)
        PhxEvents.CLOSE:
            print("Channel closed.")
        PhxEvents.ERROR:
            emit_signal("error", data.payload)
        SupabaseEvents.DELETE, SupabaseEvents.INSERT, SupabaseEvents.UPDATE:
            print("Received %s event..." % data.event)
            for channel in channels:
                if channel.topic == data.topic:
                    channel.publish(data)
                    return

func _check_response(message : Dictionary):
        if message.event == PhxEvents.REPLY:
            if message.payload.status == "ok":
                return 0

func get_message(pb : PoolByteArray) -> Dictionary:
    return parse_json(pb.get_string_from_utf8())
        
func send_message(json_message : Dictionary) -> void:
    if not _ws_client.get_peer(1).is_connected_to_host():
        yield(self, "connected")
        _ws_client.get_peer(1).put_packet(to_json(json_message).to_utf8())
    else:
        _ws_client.get_peer(1).put_packet(to_json(json_message).to_utf8())
        
        
func _send_heartbeat() -> void:
    send_message({
        "topic": "phoenix",
        "event": "heartbeat",
        "payload": {},
        "ref": null
    })
    
func _on_timeout() -> void:
    if _ws_client.get_peer(1).is_connected_to_host():
        _send_heartbeat()

func _process(delta : float) -> void:
    _ws_client.poll()
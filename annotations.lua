---Converts given value to boolean using following rules:
---	nil, false, 0, empty string, '0' string are treated as false, everything else as true.
--
---[View documents](https://openrb.com/docs/lua.htm#toboolean)
---@param value any
---@return boolean
function toboolean(value) end

---Delays script execution by the specified number of seconds (can be a fraction).
--
---[View documents](https://openrb.com/docs/lua.htm#sleep)
---@param delay number
---@return nil
function sleep(delay) end

---Adds a message to Alert list. This function behaves exactly as string.format.
--
---[View documents](https://openrb.com/docs/lua.htm#alert)
---@param fmt string|number
---@param ... ...
---@return nil
function alert(fmt, ...) end

---Logs any number of variables in human-readable format.
--
---[View documents](https://openrb.com/docs/lua.htm#log)
---@param ... any
---@return nil
function log(...) end

---Splits string by given separator string. Returns Lua table.
--
---[View documents](https://openrb.com/docs/lua.htm#string.split)
---@param str string
---@param sep string
---@return table
function string.split(str, sep) end

---Trims leading and trailing spaces off a given string.
--
---[View documents](https://openrb.com/docs/lua.htm#string.trim)
---@param str string
---@return string
function string.trim(str) end

---Returns the rounded value of x to specified precision (number of digits after the decimal point, value between 0 and 10, defaults to 0).
--
---[View documents](https://openrb.com/docs/lua.htm#math.round)
---@param x number
---@param presicion number
---@return number
function math.round(x, presicion) end

---Reads whole file contents, returns string on success, or nil when file cannot be read.
--
---[View documents](https://openrb.com/docs/lua.htm#io.readfile)
---@param file string
---@return string|nil
function io.readfile(file) end

---Executes a process returns process output as a string on success, or nil when process cannot be executed.
--
---[View documents](https://openrb.com/docs/lua.htm#io.readproc)
---@param proc string
---@return string
---@return exitcode
function io.readproc(proc) end

---Overwrites file with the given string contents, returns true on success, or nil when file cannot be written.
--
---[View documents](https://openrb.com/docs/lua.htm#io.writefile)
---@param file string
---@param data string
---@return true|nil
function io.writefile(file, data) end

---Returns true when the given path (file or directory) exists, false otherwise.
--
---[View documents](https://openrb.com/docs/lua.htm#io.exists)
---@param path string
---@return boolean
function io.exists(path) end

---Returns table with unsorted directory contents, or nil when directory is not readable.
--
---[View documents](https://openrb.com/docs/lua.htm#io.ls)
---@param directory string
---@return table|nil
function io.ls(directory) end

---Returns size and modification timestamp of the given path (file or directory). Size and timestamp will be zero when path does not exist.
--
---[View documents](https://openrb.com/docs/lua.htm#io.stat)
---@param path string
---@return number size
---@return number timestamp
---@return string type
function io.stat(path) end

---Returns two values: current timestamp in seconds and timestamp fraction in microseconds.
--
---[View documents](https://openrb.com/docs/lua.htm#os.microtime)
---@return number timestamp
---@return number timestamp_fraction
function os.microtime() end

---Returns time difference as a floating point value between current timestamp and timestamp components passed to it (seconds, microseconds).
--
---[View documents](https://openrb.com/docs/lua.htm#os.udifftime)
---@param sec number
---@param usec number
---@return number
function os.udifftime(sec, usec) end

---Delays script execution by the specified number of seconds (can be a fraction).
--
---[View documents](https://openrb.com/docs/lua.htm#os.sleep)
---@param delay number
function os.sleep(delay) end

---@class dt
--
---[View documents](https://openrb.com/docs/lua.htm#grp-info)
dt = {
	---@type number - 1-bit boolean
	bool = 1,
	---@type number - 1-bit controlled number
	bit2 = 2,
	---@type number - 3-bit controlled number
	bit4 = 3,
	---@type number - 1-byte ASCII character string
	char = 4,
	---@type number - 1-byte unsigned integer
	uint8 = 5,
	---@type number - 1-byte unsigned integer [0..100]
	scale = 5001,
	---@type number - 1-byte unsigned integer [0..360]
	angle = 5003,
	---@type number - 1-byte signed integer
	int8 = 6,
	---@type number - 2-byte unsigned integer
	uint16 = 7,
	---@type number - 2-byte signed integer
	int16 = 8,
	---@type number - 3-byte unsigned integer
	uint24 = 232,
	---@type number - RGB color, alias of dt.uint24
	rgb = 232600,
	---@type number - 2-byte floating point number
	float16 = 9,
	---@type number - 3-byte time / day
	time = 10,
	---@type number - 3-byte date
	date = 11,
	---@type number - 4-byte unsigned integer number
	uint32 = 12,
	---@type number - 4-byte signed integer number
	int32 = 13,
	---@type number - 4-byte unsigned integer number
	float32 = 14,
	---@type number  - 8-byte signed integer number
	int64 = 29,
	---@type number - 14-byte ASCII string, null characters '\0' are discarded during decoding
	string = 16,
	---@type number - 250-byte string, cannot be sent to TP bus
	text = 255,
}

---@class grp
grp = {}

---Returns single object for the given alias. Object value will be decoded if data type is set.
--
---Returns nil when object cannot be found, otherwise it returns table with the following fields:
---    address - object group address
---    updatetime - latest update time in UNIX timestamp format.
---                 Use os.date() to convert to readable date formats
---    name - unique object name
---    datatype - object data type
---    decoded - set to true when decoded value is available
---    value - decoded object value
--
---[View documents](https://openrb.com/docs/lua.htm#grp.find)
---@param alias string
---@return table
function grp.find(alias) end

---Returns table containing objects with the given tag.
---
---Tags parameter can be either a table or a string.
---Mode parameter can be either 'or' (default — returns objects that have any of given tags) or 'and' (return objects that have all of given tags).
---You can use object functions on the returned table.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.tag)
---@param tags table|string
---@param mode? string
---@return table
function grp.tag(tags, mode) end

---Find all objects with matching data type.
---Dpt can be either a string ("bool", "scale", "uint32" etc) or a field from dt table (dt.bool, dt.scale, dt.uint32).
--
---Example: if dpt is set to dt.uint8: in normal mode all sub-datatypes like dt.scale and dt.angle will be included.
---If exact data type match is required, set strict to true.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.dpt)
---@param dpt string|dt
---@param strict? boolean 
---@return table
function grp.dpt(dpt, strict) end

---Returns table with all known objects.
---[View documents](https://openrb.com/docs/lua.htm#grp.all)
---@return table
function grp.all() end

---Converts group address to object name or name to address. Returns nil when object cannot be found.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.alias)
---@param alias string
---@return string|nil
function grp.alias(alias) end

---Returns value for the given alias or nil when object cannot be found.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.getvalue)
---@param alias string
---@return any|nil
function grp.getvalue(alias) end

---Sends group write request to the given alias. Data type is taken from the database if not specified as the third parameter. Returns boolean as the result.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.write)
---@param alias string
---@param value ...
---@param datatype? dt
---@return boolean
function grp.write(alias, value, datatype) end

---Similar to grp.write. Sends group response request to the given alias.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.response)
---@param alias string
---@param value ...
---@param datatype? dt
---@return boolean
function grp.response(alias, value, datatype) end

---Sends group read request to the given alias.
---Note: this function returns immediately and cannot be used to return the result of read request.
---Use event-based script instead.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.read)
---@param alias string
---@return any
function grp.read(alias) end

---Sends group read request to the given alias or multiple aliases (if alias is a Lua table) and waits for a reply.
--Returns decoded value for a single alias or a Lua table with values for multiple aliases in case of a successful read.
--Otherwise returns nil plus error message. Default timeout is 3 seconds.
---[View documents](https://openrb.com/docs/lua.htm#grp.readvalue)
---@param alias string|table
---@param timeout number
---@return ...|nil
---@return string?
function grp.readvalue(alias, timeout) end

---Similar to grp.write, but does not send new value to TP bus.
---Useful for objects that are used only in visualization.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.update)
---@param alias string
---@param value ...
---@param datatype? dt
---@return boolean
function grp.update(alias, value, datatype) end

---Sends group write request to the given alias only when difference between 
---current value and new value is more or equal to the specified delta
---(non-numeric values use exact comparison, default integer delta 1, default
--floating point delta is 0.1).
--
---Status object value is used for comparison when status object alias is set.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.checkwrite)
---@param alias string
---@param value ...
---@param delta? integer
---@param status? number
---@return nil
function grp.checkwrite(alias, value, delta, status) end

---Similar to grp.checkwrite, but uses grp.update for sending.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.checkupdate)
---@param alias string
---@param value ...
---@param delta? integer
---@param status? number
---@return nil
function grp.checkupdate(alias, value, delta, status) end

---Similar to grp.checkwrite, but uses grp.response for sending.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.checkresponse)
---@param alias string
---@param value ...
---@param delta? integer
---@param status? number
---@return nil
function grp.checkresponse(alias, value, delta, status) end

---Returns table with all tags that are set for the given alias.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.gettags)
---@param alias string
---@return table
function grp.gettags(alias) end

---Adds single or multiple tags to the given alias.
---Tags parameter can be either a string (single tag) or a table consisting of strings (multiple tags).
--
---[View documents](https://openrb.com/docs/lua.htm#grp.addtags)
---@param alias string
---@param tags string|table
---@return boolean|nil
function grp.addtags(alias, tags) end

---Removes single or multiple tags to the given alias.
---Tags parameter can be either a string (single tag) or a table consisting of strings (multiple tags).
--
---[View documents](https://openrb.com/docs/lua.htm#grp.removetags)
---@param alias string
---@param tags string|table
---@return boolean|nil
function grp.removetags(alias, tags) end

---Removes all tags for given alias.
--
---[View documents](https://openrb.com/docs/lua.htm#grp.removealltags)
---@param alias string
---@return boolean|nil
function grp.removealltags(alias) end

---Overwrites all tags for the given alias.
---Tags parameter can be either a string (single tag) or a table consisting of strings (multiple tags).
--
---[View documents](https://openrb.com/docs/lua.htm#grp.settags)
---@param alias string
---@param tags string|table
---@return boolean|nil
function grp.settags(alias,tags) end

---@class config
---@field datatype string|dt - object data type. Can be either a string ("bool", "scale", "uint32" etc) or a field from dt table (dt.bool, dt.scale, dt.uint32)
---@field name string - unique object name (string)
---@field address string|number - object address (string or number), when not set the next free address in the range will be used
---@field virtual boolean - when address is not set select which address range to use (boolean: true to use virtual range, false to use standard range)
---@field tags string|table - object tags, either a string (single tag) or a table consisting of strings (multiple tags). Overwrites tags for existing objects
---@field visparams table - visualization parameters (table or JSON string)
---@field enums table - custom values (table or JSON string)
---@field forcename boolean - set to true to overwrite a name for an existing object
---@field log boolean - logging policy (boolean), default policy is used when not set
---@field comment string - object comments (string)
---@field covincr number - BACnet change-of-value increment (number), only applicable to numeric data types
---@field readoninit boolean - send read request on system start (boolean), does not apply to virtual objects
---@field export boolean - export flag (boolean)
---@field pollinterval number - poll interval in seconds (number), does not apply to virtual objects
---@field units string - object units (string)
config = {}
---Creates a new or overwrites an existing object based on provided config, which must be a Lua table.
---Returns object address (string) on success, nil plus error message otherwise.
--
---If an object with the same group address already exists all provided properties except for the object name will be updated.
---To update the name for an existing object set forcename property to true.
--
--- ```
--- -- create new object with known address
---address = grp.create({
---  datatype = dt.float16,
---  address = '1/1/1',
---  name = 'My first object',
---  comment = 'This is my new object',
---  units = 'W',
---  tags = { 'My tag A', 'My tag B' },
---})
--
---- create new object with automatic address assignment
---address = grp.create({
---  datatype = dt.bool,
---  name = 'My second object',
---})
--- ```
--
---[View documents](https://openrb.com/docs/lua.htm#grp.create)
---@param config config
---@return string|nil
---@return string?
function grp.create(config) end

---@class json
json = {}

---Converts Lua variable to JSON string.
---Script execution is stopped in case of an error.
--
---[View documents](https://openrb.com/docs/lua.htm#json.encode)
---@param value ...
---@return string
function json.encode(value) end

---Converts JSON string to Lua variable.
---Script execution is stopped in case of an error.
--
---[View documents](https://openrb.com/docs/lua.htm#json.decode)
---@param value ...
---@return ...
function json.decode(value) end

---Converts JSON string to Lua variable in protected mode, returns nil on error.
--
---[View documents](https://openrb.com/docs/lua.htm#json.pdecode)
---@param value ...
---@return ...
function json.pdecode(value) end

---@class script
script = {}

---Sets new status (enabled/disabled) for the given script name.
---You can use _SCRIPTNAME variable for scripts that need to disable themselves.
--
---[View documents](https://openrb.com/docs/lua.htm#script.set)
---@param name string
---@param status boolean
---@return boolean|nil
---@return string?
function script.set(name, status) end

---Enables script, shortcut for script.set(name, true).
--
---[View documents](https://openrb.com/docs/lua.htm#script.enable)
---@param name string
---@return boolean|nil
---@return string?
function script.enable(name) end

---Disables script, shortcut for script.set(name, false).
--
---[View documents](https://openrb.com/docs/lua.htm#script.disable)
---@param name string
---@return boolean|nil
---@return string?
function script.disable(name) end

---Returns status (enabled/disabled) for the given script name, or nil when script is not found.
--
---[View documents](https://openrb.com/docs/lua.htm#script.status)
---@param name string
---@return boolean
function script.status(name) end

---Returns two values: number of enabled and disabled scripts in the given category.
--
---[View documents](https://openrb.com/docs/lua.htm#script.categorystatus)
---@param category string
---@return number
---@return number
function script.categorystatus(category) end

---Sets new status (enabled/disabled) for all scripts in the given category.
--
---[View documents](https://openrb.com/docs/lua.htm#script.categoryset)
---@param category string
---@param status boolean
---@return nil
function script.categoryset(category, status) end

---Enables all scripts in the given category, shortcut for script.categoryset(category, true).
--
---[View documents](https://openrb.com/docs/lua.htm#script.categoryenable)
---@param category string
---@return nil
function script.categoryenable(category) end

---Disables all scripts in the given category, shortcut for script.categoryset(category, false).
--
---[View documents](https://openrb.com/docs/lua.htm#script.categorydisable)
---@param category string
---@return nil
function script.categorydisable(category) end

---@class storage
---Storage object provides persistent key-value data storage for user scripts.
---Only the following Lua data types are supported: boolean, number, string, table.
--
---[View documents](https://openrb.com/docs/lua.htm#10)
storage = {}

---Sets new value for the given key.
---Old value is overwritten.
---Returns boolean as the result and an optional error string.
--
---[View documents](https://openrb.com/docs/lua.htm#storage.set)
---@param key string
---@param value boolean|number|string|table
---@return boolean
function storage.set(key, value) end

---Gets value for the given key or returns default value (nil if not specified) if key is not found.
--
---[View documents](https://openrb.com/docs/lua.htm#storage.get)
---@param key string
---@param default ... ?
---@return ...?
function storage.get(key , default) end

---Deletes the given storage key. Returns boolean as the result.

---[View documents](https://openrb.com/docs/lua.htm#storage.delete)
---@param key string
---@return boolean
function storage.delete(key) end

---@class serial
serial = {}

---@alias baudrate
---|300
---|600
---|1200
---|2400
---|4800
---|9600
---|19200
---|38400
---|57600
---|115200 default
---|230400

---@alias parity
---|"none" default
---|"even"
---|"odd"

---@alias databits
---|5
---|6
---|7
---|8 default

---@alias stopbits
---|1 default
---|2

---@alias duplex
---|"full" default
---|"half"

---Opens given port, returns: port handle, or, in case of error, nil plus error message.
---Parameters must be a Lua table, default values (in bold) are used when field is not present:
--
---[View documents](https://openrb.com/docs/lua.htm#serial.open)
---@param device string
---@param parameters {baudrate: baudrate, parity: parity, databits: databits, stopbits: stopbits, duplex: duplex}
function serial.open(device, parameters) end

---Writes the specified string to the serial port.
---Returns number of bytes written, or, in case of error, nil plus error message.
--
---[View documents](https://openrb.com/docs/lua.htm#serial.write)
---@param str string
---@return number
---@return string ?
function serial.write(str) end

---Reads until timeout occurs or the specified number of bytes is received, whichever happens first.
--Returns data plus number of bytes read, or, in case of error, nil plus error message.
--
---[View documents](https://openrb.com/docs/lua.htm#serial.read)
---@param bytes number
---@param timeout number
---@return string
---@return string?
function serial.read(bytes, timeout) end

---Flushes any read/unsent bytes, returns flush operation result.
--
---[View documents](https://openrb.com/docs/lua.htm#serial.flush)
---@return ...
function serial.flush() end

---Waits until all output has been transmitted, returns drain operation result.
--
---[View documents](https://openrb.com/docs/lua.htm#serial.drain)
---@return ...
function serial.drain() end

---Closes serial port, no other port functions may be called afterwards.
--
---[View documents](https://openrb.com/docs/lua.htm#serial.close)
function serial.close() end

---@class encdec
encdec = {}

---Returns md5 hash value of the given string as 32-character hex string or raw binary string if raw parameter is true.
--
---[View documents](https://openrb.com/docs/lua.htm#encdec.md5)
---@param str string
---@param raw boolean
---@return string
function encdec.md5(str, raw) end

---Returns sha1 hash value of the given string as 40-character hex string or raw binary string if raw parameter is true.
--
---[View documents](https://openrb.com/docs/lua.htm#encdec.sha1)
---@param str string
---@param raw boolean
---@return string
function encdec.sha1(str, raw) end

---Returns sha256 hash value of the given string as 64-character hex string or raw binary string if raw parameter is true.
--
---[View documents](https://openrb.com/docs/lua.htm#encdec.sha256)
---@param str string
---@param raw boolean
---@return string
function encdec.sha256(str, raw) end

---Returns the given string encoded in base64 format.
--
---[View documents](https://openrb.com/docs/lua.htm#encdec.base64enc)
---@param str string
---@return string
function encdec.base64enc(str) end

--TODO: create repo / docs / publish / forums

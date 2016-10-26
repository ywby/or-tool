local mysql = require "mod_mysql_pool"
local redis = require "mod_redis_pool"
  
--local res = mysql:query("select * from mysql_redis_info_test where id = 1 limit 1")
--local res = mysql:query("insert into mysql_redis_info_test (flag, value) values ('insert1', 'value1')")
local data = {}

--local resInfo = ''
--for _, info in ipairs(res) do
--    resInfo = info.flag..info.value
--end
local flag, redis_handler = redis.getClient()
if flag and redis_handler then
    local value,_ = redis_handler:get('cat')
    ngx.say("get:",value)
end 
--ngx.say("get hello")


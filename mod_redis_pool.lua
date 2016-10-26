local redis = require("resty.redis")

local _M = {}
_M.VERSION = '1.0'

local mt = {_index = _M}

local redis_pool = {}

function _M.getClient()

    if ngx.ctx[redis_pool] then
        return true, ngx.ctx[redis_pool]
    end
 
    local client, errmsg = redis:new()
    if not client then
        return false, "redis.socket_failed: " .. (errmsg or "nil")
    end
 
    client:set_timeout(10000)  --10秒
 
    --local result, errmsg = client:connect(redisConfig.REDIS_HOST, redisConfig.REDIS_PORT)
    local result, errmsg = client:connect("192.168.1.205", 6379)
    if not result then
        return false, errmsg
    end
 
    ngx.ctx[redis_pool] = client
     
    return true, ngx.ctx[redis_pool]    
end


function _M.close()
    if ngx.ctx[redis_pool] then
        ngx.ctx[redis_pool]:set_keepalive(60000, 300)
        ngx.ctx[redis_pool] = nil
    end
end

return _M 


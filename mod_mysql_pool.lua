local mysql = require("resty.mysql")

local _M = {}
_M.VERSION = '1.0'

local mt = {_index = _M}

local MySQL = {}

function _M.getClient()
    
    if ngx.ctx[MySQL] then
        return ngx.ctx[MySQL]
    end
 
    local client, errmsg = mysql:new()
 
    if not client then
        return false, "mysql.socket_failed: " .. (errmsg or "nil") 
    end
 
    client:set_timeout(3000)
 
    local options = {
        host = '127.0.0.1',
        user = 'root',
        password = 'ywby2160', 
        database = 'test_db', 
        port = 3306 
    }
 
    local result, errmsg, errno = client:connect(options)
 
    ngx.ctx[MySQL] = client
    return ngx.ctx[MySQL]
end


function _M.close()
    if ngx.ctx[MySQL] then
        ngx.ctx[MySQL]:set_keepalive(0, 100)
        ngx.ctx[MySQL] = nil
    end
end

function _M:query(query)
    local result, errmsg, errno = self:getClient():query(query)
 
    return result
end
 
return _M 


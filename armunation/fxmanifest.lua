fx_version('cerulean')
games({ 'gta5' })
lua54 'yes'
shared_script {"@es_extended/imports.lua","config.lua"}

server_scripts({
    '@mysql-async/lib/MySQL.lua',
    "server.lua"
});

client_scripts({
    "pmenu.lua",
    "client.lua"
});
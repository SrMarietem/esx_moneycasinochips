fx_version 'cerulean'
games { 'gta5' }

author 'SrMarietem'
description 'Script de fichas para FiveM en ESX'
version '1.0.0'

client_scripts {
    'client.lua',
    'config.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'server.lua',
    'config.lua',
}
fx_version 'cerulean'
game 'gta5'

description 'Heavy Traffic Script for QBCore'
author 'Raven'
version '1.0.0'

shared_scripts {
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

lua54 'yes'

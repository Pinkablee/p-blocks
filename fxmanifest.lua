fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Pinkable'
version '1.0.0'
description '(p-blocks), A contemporary and versatile gang block system for FiveM.'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script 'client/client.lua'
server_script 'server/version.lua'

dependencies {
	'/onesync',
  'ox_lib'
}

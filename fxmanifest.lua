lua54 'yes'
fx_version 'cerulean'
game 'gta5'

author 'Chase https://discord.gg/EgctWPu7St'
description 'Custom Head Tags with Discord API/Ace permissions and Mythic Notify'
version '1.0.0'

shared_script 'config.lua'

client_script 'client.lua'
server_script 'server.lua'

dependencies {
    'mythic_notify',
    'Badger_Discord_API'
}
const { REST, Routes, SlashCommandBuilder } = require('discord.js');
require('dotenv').config();

const commands = [
    new SlashCommandBuilder()
        .setName('genkey')
        .setDescription('Generate a new DummyHook key')
        .addStringOption(option =>
            option.setName('level')
                .setDescription('Key access level')
                .setRequired(true)
                .addChoices(
                    { name: 'Basic', value: 'Basic' },
                    { name: 'Premium', value: 'Premium' },
                    { name: 'Elite', value: 'Elite' }
                ))
        .addIntegerOption(option =>
            option.setName('duration')
                .setDescription('Key duration in days')
                .setRequired(false))
        .addStringOption(option =>
            option.setName('hwid')
                .setDescription('Hardware ID (leave empty for ANY)')
                .setRequired(false))
        .addUserOption(option =>
            option.setName('user')
                .setDescription('User to send the key to')
                .setRequired(false)),

    new SlashCommandBuilder()
        .setName('deletekey')
        .setDescription('Delete a DummyHook key')
        .addStringOption(option =>
            option.setName('key')
                .setDescription('The key to delete')
                .setRequired(true)),

    new SlashCommandBuilder()
        .setName('listkeys')
        .setDescription('List all DummyHook keys'),

    new SlashCommandBuilder()
        .setName('checkkey')
        .setDescription('Check if a key is valid')
        .addStringOption(option =>
            option.setName('key')
                .setDescription('The key to check')
                .setRequired(true))
].map(command => command.toJSON());

const rest = new REST({ version: '10' }).setToken(process.env.DISCORD_BOT_TOKEN);

(async () => {
    try {
        console.log('Started refreshing application (/) commands.');

        await rest.put(
            Routes.applicationGuildCommands(process.env.CLIENT_ID, process.env.GUILD_ID),
            { body: commands },
        );

        console.log('✓ Successfully reloaded application (/) commands.');
    } catch (error) {
        console.error('Error deploying commands:', error);
    }
})();

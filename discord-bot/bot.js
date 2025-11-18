const { Client, GatewayIntentBits, SlashCommandBuilder, EmbedBuilder, PermissionFlagsBits } = require('discord.js');
const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

// Configuration
const CONFIG = {
    TOKEN: process.env.DISCORD_BOT_TOKEN || 'YOUR_BOT_TOKEN_HERE',
    CLIENT_ID: process.env.CLIENT_ID || 'YOUR_CLIENT_ID_HERE',
    GUILD_ID: process.env.GUILD_ID || 'YOUR_GUILD_ID_HERE',
    KEYS_FILE: path.join(__dirname, '..', 'Keys', 'keylist.json'),
    ADMIN_ROLE: 'DummyHook Admin', // Role required to generate keys
    KEY_PREFIX: 'DUMMYHOOK'
};

// Create Discord client
const client = new Client({
    intents: [
        GatewayIntentBits.Guilds,
        GatewayIntentBits.GuildMessages,
        GatewayIntentBits.MessageContent
    ]
});

// Key generation function
function generateKey(level = 'Basic') {
    const randomPart = crypto.randomBytes(8).toString('hex').toUpperCase();
    const levelPrefix = level.toUpperCase().substring(0, 4);
    const year = new Date().getFullYear();
    return `${CONFIG.KEY_PREFIX}-${levelPrefix}-${randomPart}-${year}`;
}

// Load existing keys
function loadKeys() {
    try {
        if (fs.existsSync(CONFIG.KEYS_FILE)) {
            const data = fs.readFileSync(CONFIG.KEYS_FILE, 'utf8');
            return JSON.parse(data);
        }
    } catch (error) {
        console.error('Error loading keys:', error);
    }
    return {};
}

// Save keys
function saveKeys(keys) {
    try {
        const dir = path.dirname(CONFIG.KEYS_FILE);
        if (!fs.existsSync(dir)) {
            fs.mkdirSync(dir, { recursive: true });
        }
        fs.writeFileSync(CONFIG.KEYS_FILE, JSON.stringify(keys, null, 2));
        return true;
    } catch (error) {
        console.error('Error saving keys:', error);
        return false;
    }
}

// Add key to database
function addKey(key, level, duration = 30, hwid = 'ANY') {
    const keys = loadKeys();
    const expiry = Math.floor(Date.now() / 1000) + (duration * 24 * 60 * 60); // Convert days to seconds
    
    keys[key] = {
        Level: level,
        Expiry: expiry,
        HWID: hwid,
        GeneratedAt: new Date().toISOString()
    };
    
    return saveKeys(keys);
}

// Delete key from database
function deleteKey(key) {
    const keys = loadKeys();
    if (keys[key]) {
        delete keys[key];
        return saveKeys(keys);
    }
    return false;
}

// List all keys
function listKeys() {
    return loadKeys();
}

// Bot ready event
client.once('ready', () => {
    console.log(`✓ Logged in as ${client.user.tag}`);
    console.log(`✓ Bot is ready!`);
    console.log(`✓ Serving ${client.guilds.cache.size} guilds`);
});

// Interaction handler
client.on('interactionCreate', async interaction => {
    if (!interaction.isChatInputCommand()) return;

    const { commandName } = interaction;

    // Check if user has admin role
    const hasAdminRole = interaction.member.roles.cache.some(role => 
        role.name === CONFIG.ADMIN_ROLE || role.permissions.has(PermissionFlagsBits.Administrator)
    );

    if (!hasAdminRole && commandName !== 'checkkey') {
        return interaction.reply({
            content: '❌ You do not have permission to use this command!',
            ephemeral: true
        });
    }

    try {
        if (commandName === 'genkey') {
            const level = interaction.options.getString('level') || 'Basic';
            const duration = interaction.options.getInteger('duration') || 30;
            const hwid = interaction.options.getString('hwid') || 'ANY';
            const user = interaction.options.getUser('user');

            const key = generateKey(level);
            const success = addKey(key, level, duration, hwid);

            if (success) {
                const embed = new EmbedBuilder()
                    .setColor(0x82C341)
                    .setTitle('✓ Key Generated Successfully')
                    .setDescription(`\`\`\`${key}\`\`\``)
                    .addFields(
                        { name: '🎫 Level', value: level, inline: true },
                        { name: '⏱️ Duration', value: `${duration} days`, inline: true },
                        { name: '🔒 HWID', value: hwid, inline: true }
                    )
                    .setTimestamp()
                    .setFooter({ text: 'DummyHook Key System' });

                if (user) {
                    try {
                        await user.send({
                            embeds: [embed],
                            content: `Your DummyHook key has been generated!\nUse this key to access DummyHook features.`
                        });
                        await interaction.reply({
                            content: `✓ Key sent to ${user.tag}!`,
                            ephemeral: true
                        });
                    } catch (error) {
                        await interaction.reply({
                            embeds: [embed],
                            ephemeral: true
                        });
                    }
                } else {
                    await interaction.reply({
                        embeds: [embed],
                        ephemeral: true
                    });
                }
            } else {
                await interaction.reply({
                    content: '❌ Failed to generate key. Check bot permissions.',
                    ephemeral: true
                });
            }
        } else if (commandName === 'deletekey') {
            const key = interaction.options.getString('key');
            const success = deleteKey(key);

            if (success) {
                const embed = new EmbedBuilder()
                    .setColor(0xFF5555)
                    .setTitle('✓ Key Deleted')
                    .setDescription(`Key \`${key}\` has been removed from the database.`)
                    .setTimestamp();

                await interaction.reply({
                    embeds: [embed],
                    ephemeral: true
                });
            } else {
                await interaction.reply({
                    content: '❌ Key not found or failed to delete.',
                    ephemeral: true
                });
            }
        } else if (commandName === 'listkeys') {
            const keys = listKeys();
            const keyCount = Object.keys(keys).length;

            if (keyCount === 0) {
                return interaction.reply({
                    content: '❌ No keys found in database.',
                    ephemeral: true
                });
            }

            const keyList = Object.entries(keys)
                .slice(0, 10)
                .map(([key, data]) => {
                    const expiryDate = new Date(data.Expiry * 1000);
                    const isExpired = Date.now() > expiryDate.getTime();
                    return `\`${key}\` - ${data.Level} ${isExpired ? '(Expired)' : ''}`;
                })
                .join('\n');

            const embed = new EmbedBuilder()
                .setColor(0x82C341)
                .setTitle('📋 Key List')
                .setDescription(keyList + (keyCount > 10 ? `\n\n*...and ${keyCount - 10} more keys*` : ''))
                .setFooter({ text: `Total: ${keyCount} keys` })
                .setTimestamp();

            await interaction.reply({
                embeds: [embed],
                ephemeral: true
            });
        } else if (commandName === 'checkkey') {
            const key = interaction.options.getString('key');
            const keys = loadKeys();
            const keyData = keys[key];

            if (keyData) {
                const expiryDate = new Date(keyData.Expiry * 1000);
                const isExpired = Date.now() > expiryDate.getTime();

                const embed = new EmbedBuilder()
                    .setColor(isExpired ? 0xFF5555 : 0x82C341)
                    .setTitle(isExpired ? '❌ Key Expired' : '✓ Key Valid')
                    .addFields(
                        { name: '🎫 Level', value: keyData.Level, inline: true },
                        { name: '⏱️ Expires', value: expiryDate.toLocaleDateString(), inline: true },
                        { name: '🔒 HWID', value: keyData.HWID || 'ANY', inline: true }
                    )
                    .setTimestamp();

                await interaction.reply({
                    embeds: [embed],
                    ephemeral: true
                });
            } else {
                await interaction.reply({
                    content: '❌ Invalid key or key not found.',
                    ephemeral: true
                });
            }
        }
    } catch (error) {
        console.error('Error handling command:', error);
        await interaction.reply({
            content: '❌ An error occurred while processing the command.',
            ephemeral: true
        });
    }
});

// Login
client.login(CONFIG.TOKEN).catch(error => {
    console.error('Failed to login:', error);
    process.exit(1);
});

// Graceful shutdown
process.on('SIGINT', () => {
    console.log('\nShutting down gracefully...');
    client.destroy();
    process.exit(0);
});

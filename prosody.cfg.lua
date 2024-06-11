-- telepath.im Prosody server configuration
-- Configuration docs: https://prosody.im/doc/configure

---------- Server-wide settings ----------

-- This is a (by default, empty) list of accounts that are admins
-- for the server. Note that you must create the accounts separately
-- (see https://prosody.im/doc/creating_accounts for info)
-- Example: admins = { "user1@example.com", "user2@example.net" }
admins = { "ari@ari.lt" }

-- This option allows you to specify additional locations where Prosody
-- will search first for modules. See https://modules.prosody.im/
--plugin_paths = {}

-- This is the list of modules Prosody will load on startup.
-- See https://prosody.im/doc/modules
modules_enabled = {

    -- Generally required
        "disco"; -- Service discovery
        "roster"; -- Allow users to have a roster. Recommended ;)
        "saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
        "tls"; -- Add support for secure TLS on c2s/s2s connections

    -- Not essential, but recommended
        "blocklist"; -- Allow users to block communications with other users
        "bookmarks"; -- Synchronise the list of open rooms between clients
        "carbons"; -- Keep multiple online clients in sync
        "dialback"; -- Support for verifying remote servers using DNS
        "limits"; -- Enable bandwidth limiting for XMPP connections
        "pep"; -- Allow users to store public and private data in their account
        "private"; -- Legacy account storage mechanism (XEP-0049)
        "smacks"; -- Stream management and resumption (XEP-0198)
        "vcard4"; -- User profiles (stored in PEP)
        "vcard_legacy"; -- Conversion between legacy vCard and PEP Avatar, vcard

    -- Nice to have
        "csi_simple"; -- Simple but effective traffic optimizations for mobile devices
        "invites"; -- Create and manage invites
        "invites_adhoc"; -- Allow admins/users to create invitations via their client
        "invites_register"; -- Allows invited users to create accounts
        "ping"; -- Replies to XMPP pings with pongs
        "register"; -- Allow users to register on this server using a client and change passwords
        "time"; -- Let others know the time here on this server
        "uptime"; -- Report how long server has been running
        "version"; -- Replies to server version requests
        "mam"; -- Store recent messages to allow multi-device synchronization
        "turn_external"; -- Provide external STUN/TURN service for e.g. audio/video calls

    -- Admin interfaces
        "admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
        "admin_shell"; -- Allow secure administration via 'prosodyctl shell'

    -- HTTP modules
        "bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
        --"http_openmetrics"; -- for exposing metrics to stats collectors
        "websocket"; -- XMPP over WebSockets

    -- Other specific functionality
        "announce"; -- Send announcement to all online users
        "groups"; -- Shared roster support
        --"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
        "mimicking"; -- Prevent address spoofing
        --"motd"; -- Send a message to users when they log in
        --"proxy65"; -- Enables a file transfer proxy service which clients behind NAT can use
        "s2s_bidi"; -- Bi-directional server-to-server (XEP-0288)
        "server_contact_info"; -- Publish contact information for this service
        "tombstones"; -- Prevent registration of deleted accounts
        "watchregistrations"; -- Alert admins of registrations
        "welcome"; -- Welcome users who register accounts

        -- User-enabled modules
        "cloud_notify";
        "cloud_notify_extensions";
        "http_altconnect";
        "lastactivity";
        "privilege";
        "block_registrations"
}

-- These modules are auto-loaded, but should you want
-- to disable them then uncomment them here:

modules_disabled = {
    -- "offline"; -- Store offline messages
    -- "c2s"; -- Handle client connections
    -- "s2s"; -- Handle server-to-server connections
    -- "posix"; -- POSIX functionality, sends server to background, etc.
}

-- Server-to-server authentication
-- Require valid certificates for server-to-server connections?
-- If false, other methods such as dialback (DNS) may be used instead.

s2s_secure_auth = true
c2s_require_encryption = true
s2s_require_encryption = true

-- Bump stream management timeout to 24 hours for smacks module

smacks_hibernation_time = 86400

-- Some servers have invalid or self-signed certificates. You can list
-- remote domains here that will not be required to authenticate using
-- certificates. They will be authenticated using other methods instead,
-- even when s2s_secure_auth is enabled.

--s2s_insecure_domains = { "insecure.example" }

-- Even if you disable s2s_secure_auth, you can still require valid
-- certificates for some domains by specifying a list here.

--s2s_secure_domains = { "jabber.org" }

-- Plugin server

plugin_server = "https://modules.prosody.im/rocks/"

-- Rate limits
-- See https://prosody.im/doc/modules/mod_limits

limits = {
    c2s = {
        rate = "10mb/s";
    };
    s2sin = {
        rate = "5mb/s";
    };
}

-- Required for init scripts and prosodyctl
pidfile = "/var/run/prosody/prosody.pid"

-- Authentication
-- See https://prosody.im/doc/authentication

authentication = "internal_hashed"

-- Account registration
-- See https://prosody.im/doc/modules/mod_register

allow_registration = true
registration_invite_only = true

-- Tombstones
-- See https://prosody.im/doc/modules/mod_tombstones

user_tombstone_expire = 60*86400

-- Storage
-- See https://prosody.im/doc/storage

--storage = "sql" -- Default is "internal"

-- For the "sql" backend, you can uncomment *one* of the below to configure:
--sql = { driver = "SQLite3", database = "prosody.sqlite" } -- Default. 'database' is the filename.
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }

-- Archiving configuration
-- See https://prosody.im/doc/modules/mod_mam

archive_expires_after = "4w" -- Remove archived messages after 4 weeks

-- Audio/video call relay (STUN/TURN)
-- See https://prosody.im/doc/turn

turn_external_host = "turn.ari.lt"
turn_external_secret = "..." --CHANGE ME

-- Logging configuration
-- See https://prosody.im/doc/logging

log = {
    error = "/var/log/prosody/prosody.err";
    -- info = "/var/log/prosody/prosody.log"; -- Change 'info' to 'debug' for verbose logging
    -- "*syslog"; -- Uncomment this for logging to syslog
    -- "*console"; -- Log to the console, useful for debugging when running in the foreground
}

-- Statistics
-- See https://prosody.im/doc/statistics

-- statistics = "internal"

-- Certificates
-- See https://prosody.im/doc/certificates

certificates = "certs"

-- Ports
-- See https://prosody.im/doc/ports

c2s_ports = { 5222 }
s2s_ports = { 5269 }
c2s_direct_tls_ports = { 5223 }
s2s_direct_tls_ports = { 5270 }
http_ports = { 5280 }
legacy_ssl_ports = { 5223 }

-- PEP
-- See https://prosody.im/doc/modules/mod_pep

pep_max_items = 10000

-- Contact info
-- See https://prosody.im/doc/modules/mod_server_contact_info

contact_info = {
    admin = { "https://ari.lt/#links", "mailto:ari@ari.lt", "xmpp:ari@ari.lt" };
    support = { "https://ari.lt/#links", "mailto:ari@ari.lt", "xmpp:ari@ari.lt" };
    abuse = { "https://ari.lt/#links", "mailto:ari@ari.lt", "xmpp:ari@ari.lt" };
}

-- Reserved usernames
-- See https://modules.prosody.im/mod_block_registrations

block_registrations_users = { }

-- Groups
-- See https://prosody.im/doc/modules/mod_groups

groups_file = "/etc/prosody/groups.ini"

-- HTTP stuff idk

trusted_proxies = { "127.0.0.1" }
consider_bosh_secure = true
consider_websocket_secure = true

expose_publisher = true

----------- Virtual hosts -----------
-- You need to add a VirtualHost entry for each domain you wish Prosody to serve.
-- Settings under each VirtualHost entry apply *only* to that host.

VirtualHost "ari.lt"

------ Components ------
-- See https://prosody.im/doc/components

-- Rooms (MUC service)
-- See https://prosody.im/doc/modules/mod_muc
Component "muc.ari.lt" "muc"
name = "Rooms (MUC)"
restrict_room_creation = "local"
component_admins_as_room_owners = true
muc_tombstones = true
muc_tombstone_expiry = 60*86400
max_history_messages = 1
muc_room_default_history_length = 100

-- MUC MAM
-- See https://prosody.im/doc/modules/mod_muc_mam
modules_enabled = { "muc_mam", "vcard_muc", "muc_moderation", "muc_offline_delivery" }
muc_log_by_default = true
muc_log_presences = false
log_all_rooms = true
muc_log_expires_after = "4w"
muc_log_cleanup_interval = 4*60*60

-- Hypertext (file sharing)
-- See https://prosody.im/doc/modules/mod_http_file_share
Component "ht.ari.lt" "http_file_share"
name = "Hypertext (HTTP file share)"
http_file_share_size_limit = 100*1024*1024
http_file_share_global_quota = 200*1024*1024*1024
http_file_share_expires_after = 28*86400
http_external_url = "https://ht.ari.lt/"

-- Beacon (publish-subscribe)
-- See https://prosody.im/doc/modules/mod_pubsub
Component "ps.ari.lt" "pubsub"
name = "Beacon (publish-subscribe)"
pubsub_max_items = 10000
expose_publisher = true

-- Relayer (SOCKS5 bytestreams)
-- See https://prosody.im/doc/modules/mod_proxy65
Component "relay.ari.lt" "proxy65"
name = "Relayer (SOCKS5 bytestreams)"

-- External components
-- See https://prosody.im/doc/components#adding_an_external_component

--Component "gateway.example.com"
--  component_secret = "password"

---------- End of the Prosody Configuration file ----------

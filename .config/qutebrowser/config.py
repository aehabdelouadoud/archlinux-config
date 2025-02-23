# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig(False)

# Setting default page
c.url.start_pages  = "~/.config/qutebrowser/ui/dashboard/index.html"
c.url.default_page = "~/.config/qutebrowser/ui/dashboard/index.html"

# Fonts
c.fonts.default_family   = '8.5pt "JetBrainsMono Nerd Font"'
c.fonts.completion.entry = '8.5pt "JetBrainsMono Nerd Font"'
c.fonts.debug_console    = '8.5pt "JetBrainsMono Nerd Font"'
c.fonts.prompts          = '8.5pt "JetBrainsMono Nerd Font"'
c.fonts.statusbar        = '8.5pt "JetBrainsMono Nerd Font"'

# Dark mode
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "smart"

# BINDINGS
config.bind(",m",       "hint links spawn mpv --keep-open=yes {hint-url}")
config.bind(",M",       "hint links spawn yt-dlp {hint-url} -P ~/downloads/qutebrowser")
config.bind(",p",       'hint links spawn umpv {hint-url}')

config.bind(",t",       'spawn --userscript translate')
config.bind(",r",       'spawn --userscript log_rust_url')
config.bind(',p',       'spawn --userscript save_progress {prompt:Hint/keywords:}')

config.bind("<Ctrl+k>", "completion-item-focus prev", mode="command")
config.bind("<Ctrl+j>", "completion-item-focus next", mode="command")

# UI
c.scrolling.smooth = True
c.statusbar.show   = "never"
c.tabs.show        = "never"
c.scrolling.bar    = "never"
c.zoom.default     = "100%"
config.source("./ui/themes/base16-gruvbox-material-dark-medium.config.py")
c.content.user_stylesheets = ['./ui/styles/gruvbox_material.css']

# Change download dictionary
config.set("downloads.location.directory", "~/downloads/browser")

# Set dark mode for specific websites
config.set('colors.webpage.darkmode.enabled', True, 'https://codeforces.com/*')
config.set('colors.webpage.darkmode.enabled', True, 'https://stackoverflow.com/*')
config.set('colors.webpage.darkmode.enabled', True, 'https://dart.dev/*')
config.set('colors.webpage.darkmode.enabled', True, 'https://docs.flutter.dev/*')
config.set('colors.webpage.darkmode.enabled', True, 'https://en.wikipedia.org/*')

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.blocking.adblock.lists = [
    # General ad-blocking and privacy lists
    'https://easylist.to/easylist/easylist.txt',                          # EasyList: General ad-blocking rules
    'https://easylist.to/easylist/easyprivacy.txt',                       # EasyPrivacy: Privacy-focused rules to block tracking
    'https://easylist-downloads.adblockplus.org/fanboy-annoyance.txt',    # Fanboy's Annoyance List: Blocks pop-ups, overlays, and other annoyances
    'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt',               # Fanboy's Cookie Monster List: Blocks cookie consent notices
    'https://www.i-dont-care-about-cookies.eu/abp/',                      # I Don't Care About Cookies: Another list targeting cookie notices
    'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', # Anti-circumvention: Prevents sites from bypassing adblockers

    # Harmful content and malware protection
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt',        # Blocks harmful content like malware and phishing sites
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/resource-abuse.txt', # Blocks resource-heavy sites that abuse user systems

    # Privacy and annoyance filtering
    'https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt',    # uBlock Privacy: Rules to enhance privacy
    'https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt', # uBlock Annoyances: Blocks pop-ups, overlays, and other irritations

    # General filters and compatibility
    'https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt',            # General uBlock Origin rules for ads and trackers
    'https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt', # Fixes broken site functionality caused by blocking rules

    # Additional useful filters
    'https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt',  # AdGuard SDN Filter: Blocks ads and trackers
    'https://malware-filter.gitlab.io/malware-filter/phishing-filter.txt', # Blocks phishing domains
    'https://hostfiles.frogeye.fr/firstparty-only-trackers-hosts.txt',     # Blocks first-party trackers to improve privacy
    'https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt',   # Blocks newly detected malicious domains
]

# Never accept cookies for privacy reasons
c.content.cookies.accept = 'never'

# Set the "Do Not Track" header to prevent websites from tracking user activity
c.content.headers.do_not_track = True

# Send the referrer header only within the same domain (limits exposure of browsing history)
c.content.headers.referer = 'same-domain'

# Disable local storage to prevent websites from storing data locally on your system
c.content.local_storage = False

# Do not store cookies for the session, enhancing privacy
c.content.cookies.store = False

# Block websites with invalid TLS certificates to prevent potential security risks
c.content.tls.certificate_errors = 'block'

# Disable JavaScript globally for enhanced privacy and security
c.content.javascript.enabled = False

# Define URL categories
javascript_enabled = [
    'https://mail.proton.me',
    'file:///home/x/.config/qutebrowser/ui/dashboard/index.html',
    'https://www.youtube.com',
    'https://www.reddit.com',
    'https://fennel-lang.org/see',
    'https://github.com/*',
    'https://x.com/*',
    'https://twitter.com/*',
    'https://chat.deepseek.com/*',
    'https://chatgpt.com/*',
    'https://html.duckduckgo.com/*',
    'https://duckduckgo.com/*',
    'https://finance.yahoo.com/*',
    'https://doc.rust-lang.org/stable/rust-by-example/*',
    'https://dart.dev/*',
    'https://docs.flutter.dev/*',
    'https://www.fiverr.com/*',
    'https://accounts.google.com/*',
    'https://www.google.com/*',
    'https://search.yahoo.com/*',
    'https://www.learnbyexample.org/*',
    'https://gobyexample.com/*',
    'https://www.wsj.com/*',
    'https://github.com/*',
    'https://www.amazon.com/*',
    'https://www.aliexpress.com/*',
    'https://www.notion.so/*',
    'https://finance.yahoo.com/*',
    'https://www.wsj.com/*',
    'https://www.marketwatch.com/*',
    'https://www.cnbc.com/*',
    'https://www.bloomberg.com/*',
    'https://www.investopedia.com/*',
    'https://www.marketwatch.com/*',
    'https://www.deepl.com/*'
]

local_storage_enabled = [
    'https://mail.proton.me/*',
    'https://chat.deepseek.com/*',
    'https://finance.yahoo.com/*',
    'https://chatgpt.com/*',
    'https://www.wsj.com/*',
    'https://www.aliexpress.com/*',
    'https://www.amazon.com/*',
    'https://www.notion.so/*'
    'https://www.marketwatch.com/*'
    'https://www.deepl.com/*'
]

cookies_enabled = [
    'https://mail.proton.me/*',
    'https://chat.deepseek.com/*',
    'https://www.youtube.com/*',
    'https://accounts.google.com/*',
    'https://finance.yahoo.com/*',
    'https://chatgpt.com/*',
    'https://github.com/*',
    'https://www.wsj.com/*',
    'https://www.amazon.com/*',
    'https://www.aliexpress.com/*',
    'https://www.notion.so/*'
    'https://www.marketwatch.com/*'
    'https://www.deepl.com/*'
]

clipboard_enabled = [
    'https://chatgpt.com/*',
    'https://github.com/*',
    'https://discord.com/channels/@me/*'
    'https://www.notion.so/*'
    'https://www.deepl.com/*'
]

whitelist_ads = [
        'https://www.wsj.com',
        'https://www.marketwatch.com',
        'https://finance.yahoo.com',
        'https://www.wsj.com',
        'https://www.marketwatch.com',
        'https://www.cnbc.com',
        'https://www.bloomberg.com',
        'https://www.investopedia.com',
        'https://www.deepl.com/*'
]

# Apply settings
for url in javascript_enabled:
    config.set('content.javascript.enabled', True, url)

for url in local_storage_enabled:
    config.set('content.local_storage', True, url)

for url in cookies_enabled:
    config.set('content.cookies.accept', 'all', url)

for url in clipboard_enabled:
    config.set('content.javascript.clipboard', "access", url)

config.set('content.blocking.whitelist', whitelist_ads)

config.set('content.register_protocol_handler', True, 'https://mail.proton.me/*')

## Enable Audio capture for some websites
config.set("content.desktop_capture", True, "https://discord.com/*")
## Enable desktop capture for some websites
config.set("content.media.audio_capture", True, "https://discord.com/*")


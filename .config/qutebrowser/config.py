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
config.bind(",t",       "open -t")                                                        # Open new tab
config.bind(",m",       "hint links spawn mpv --keep-open=yes {hint-url}")                # Play video via mpv
config.bind(",M",       "hint links spawn yt-dlp {hint-url} -P ~/downloads/qutebrowser")  # Download video from youtube using yt-dlp

config.bind(",T",       "spawn --userscript ~/.config/qutebrowser/scripts/translate.sh")  # Translate
config.bind(",p",       "hint links spawn ~/.config/qutebrowser/scripts/umpv.sh {hint-url}")

config.bind("<Ctrl+k>", "completion-item-focus prev", mode="command")
config.bind("<Ctrl+j>", "completion-item-focus next", mode="command")

config.bind(',k', 'spawn --userscript qute-pass --dmenu-invocation dmenu')
config.bind(',K', 'spawn --userscript qute-pass --dmenu-invocation dmenu --password-only')

# WEBSITES PERMISSIONS
## Javascript
config.set("content.javascript.clipboard", "access", "https://chat.openai.com/*") # In order to be able to copy answers.
config.set("content.javascript.clipboard", "access", "https://github.com/*") # In order to be able to copy code...etc
config.set("content.javascript.clipboard", "access", "https://discord.com/channels/@me/*") # In order to be able to copy code...etc

# Audio capture & desktop capture
config.set("content.desktop_capture", True, "https://discord.com/*")
config.set("content.media.audio_capture", True, "https://discord.com/*")

# UI
c.scrolling.smooth = True    # Smooth scrolling for making eyes feeling better
c.statusbar.show   = "never" # Never show statusbar
c.tabs.show        = "never" # Never show tabs
c.scrolling.bar    = "never"
c.zoom.default     = "80%"
config.source("./ui/themes/base16-gruvbox-material-dark-medium.config.py") # Set the theme.
c.content.user_stylesheets = ['./ui/styles/gruvbox_material.css']

# Adblocking
c.content.blocking.enabled = True
c.content.blocking.method = 'adblock'
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
# c.content.cookies.accept = 'never'

# Set the "Do Not Track" header to prevent websites from tracking user activity
c.content.headers.do_not_track = True

# Send the referrer header only within the same domain (limits exposure of browsing history)
c.content.headers.referer = 'same-domain'

# Disable local storage to prevent websites from storing data locally on your system
c.content.local_storage = False

# Do not store cookies for the session, enhancing privacy
c.content.cookies.store = True

# Block websites with invalid TLS certificates to prevent potential security risks
c.content.tls.certificate_errors = 'block'

# Disable JavaScript globally for enhanced privacy and security
c.content.javascript.enabled = False

# Re-enable JavaScript for YouTube to ensure proper functionality of the site
config.set('content.javascript.enabled', True, 'file:///home/x/.config/qutebrowser/ui/dashboard/index.html')
config.set('content.javascript.enabled', True, 'https://www.youtube.com')
config.set('content.javascript.enabled', True, 'https://mail.proton.me')
config.set('content.javascript.enabled', True, 'https://html.duckduckgo.com/html')
config.set('content.javascript.enabled', True, 'https://chat.deepseek.com')
config.set('content.javascript.enabled', True, 'https://chatgpt.com')
config.set('content.javascript.enabled', True, 'https://www.reddit.com')
config.set('content.javascript.enabled', True, 'https://fennel-lang.org/see')
config.set('content.javascript.enabled', True, 'https://github.com/*')

config.set('content.local_storage', True, 'https://mail.proton.me')
config.set('content.register_protocol_handler', True, 'https://mail.proton.me#mailto=%25s')

config.set('content.local_storage', True, 'https://chat.deepseek.com')
config.set('content.local_storage', True, 'https://chatgpt.com')
config.set('content.javascript.enabled', True, 'https://chatgpt.com')

# Change download dictionary
config.set("downloads.location.directory", "~/downloads/browser/")

# Set dark mode for specific websites
config.set("colors.webpage.darkmode.enabled", True, "https://html.duckduckgo.com/*")
config.set("colors.webpage.darkmode.enabled", True, "https://codeforces.com/*")

config.source("./hidden.py");

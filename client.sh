# to restore the file, site-settings.cfg, simply remove it, restart Android SDK Manager, Tools > Manage Add-on Sites... > Close
sed 's/https\\:\/\/dl-ssl.google.com\/android\/repository\//http\\:\/\/192.168.200.254\/android\/repository\//g' -i ~/.android/sites-settings.cfg

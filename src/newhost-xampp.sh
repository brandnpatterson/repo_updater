#!/bin/bash

# Executable file
# Place in /usr/local/bin
#
#
#
repo=$1

# -- If user input contains "/", remove it
if [[ $1 =~ '/'$ ]]; then
    repo=${repo::${#repo}-1}
fi

if [[ $1 =~ ^c5 ]]; then
    repo_substr=${repo:3}
else
    repo_substr=${repo::${#repo}-4}
fi

echo 127.0.0.1 $repo_substr.localhost >> /etc/hosts

printf "\n# $repo
<VirtualHost *:80>
    ServerName $repo_substr.localhost
    DocumentRoot \"/Applications/XAMPP/xamppfiles/htdocs/shs/$repo/trunk\"
    <Directory \"/Applications/XAMPP/xamppfiles/htdocs/shs/$repo/trunk\">
        Options Indexes FollowSymLinks Includes ExecCGI
        AllowOverride All
        Require all granted
    </Directory>
    ErrorLog \"logs/$repo_substr.localhost-error_log\"
</VirtualHost>\n" >> /Applications/XAMPP/xamppfiles/etc/extra/httpd-vhosts.conf

echo New Host Created:
echo 127.0.0.1 $repo_substr.localhost

# PHP Apache Setting Guideline

## Useful script
- Show php.ini location `php -r "phpinfo();" | grep php.ini`

## Maybe needed to change environment
1. Update `/var/www/html` permission to **www-data:www-data**
   **May cause write access denied**
2. Update php config file php.ini
   **May cause upload file failure**
   normally in `/usr/local/etc/php/php.ini`
   Set value
   - upload_max_filesize = 50M
   - post_max_size = 50M

## Maybe need to install **Nano**
`apt-get update`
`apt-get install nano`

## Do remember restart apache server after setting
- [Restart] `service apache2 restart`
- [Check status] `service apache2 status`
{ pkgs, ... }:
{
  services.phpfpm.pools."4get" = {
    user = "wwwrun";
    group = "wwwrun";
    phpPackage = pkgs.php.withExtensions ({ enabled, all }: enabled ++ (with all; [
      imagick apcu sodium
    ]));
    settings = {
      "listen"       = "/run/phpfpm/4get.sock";
      "listen.owner" = "wwwrun";
      "listen.group" = "wwwrun";
      "listen.mode"  = "0660";
      "pm"              = "ondemand";
      "pm.max_children" = 20;
    };
  };
  services.httpd = {
    enable    = true;
    adminAddr = "admin@localhost";
    extraModules = [
      "filter" "rewrite" "proxy" "proxy_fcgi"
      "http2" "headers" "deflate" "socache_shmcb"
    ];
    extraConfig = ''
      ServerName localhost
      ServerTokens Prod
      ServerSignature Off
      AddDefaultCharset UTF-8
      Header set X-Content-Type-Options "nosniff"
      Header set Content-Security-Policy "frame-ancestors 'self';"
      SSLCipherSuite HIGH:MEDIUM:!MD5:!RC4:!3DES
      SSLProxyCipherSuite HIGH:MEDIUM:!MD5:!RC4:!3DES
      SSLProtocol all -SSLv3
      SSLProxyProtocol all -SSLv3
      SSLSessionCache shmcb:/run/httpd/ssl_scache(512000)
      SSLSessionCacheTimeout 300
    '';
    virtualHosts."localhost" = {
      hostName     = "localhost";
      documentRoot = "/var/www/4get";
      forceSSL     = true;
      sslServerCert = "/etc/httpd/certs/localhost.pem";
      sslServerKey  = "/etc/httpd/certs/localhost-key.pem";
      extraConfig = ''
        Protocols h2 http/1.1
        AddOutputFilterByType DEFLATE application/json
        AddOutputFilterByType DEFLATE application/javascript
        AddOutputFilterByType DEFLATE text/html
        AddOutputFilterByType DEFLATE text/plain
        AddOutputFilterByType DEFLATE text/css
        <FilesMatch \.php$>
            SetHandler "proxy:unix:/run/phpfpm/4get.sock|fcgi://localhost/"
        </FilesMatch>
        <Directory /var/www/4get>
            Options -MultiViews
            AllowOverride All
            Require all granted
            DirectoryIndex index.php index.html
            RewriteEngine On
            RewriteCond %{REQUEST_FILENAME} !-d
            RewriteCond %{REQUEST_FILENAME} !-f
            RewriteRule ^([^\.]+)$ $1.php [NC,L]
        </Directory>
        <Directory /var/www/4get/data/>
            Order Deny,Allow
            Deny from all
        </Directory>
      '';
    };
  };
}

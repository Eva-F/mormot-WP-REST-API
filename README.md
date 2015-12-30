# A mORMot WP REST API (and WooCommerce API) consumer

####The content:
**WPRestAPI/WPRestAPI.pas** 
* the library enables to consume Wordpress(or Woocommerce) data and to work with them using ORM classes
* processes Authentication

**WPRESTAPIModels/WPRESTAPIModels.pas**
* example of ORM classes for Wordpress ( or Woocommerce) records

**chimera**
* lightweight, fast and simple JSON library - see http://arcana.sivv.com/chimera

**WPRESTAPI.json**
* file of setting for consuming of WP REST API 
* it is neccessary to complement it by own values

**WOORESTAPI.json**
* file of setting for consuming of WooCommerce API 
* it is neccessary to complement it by own values

**wordpressOauth.dpr, wordpressaurh.pas,ordpressaurh.dfm** 
* project example 
  
#### Requirements:  
* for Wordpress consuming
    * WP REST API plugin  https://wordpress.org/plugins/json-rest-api/  (I tested my library with this plugin)
      or WordPress REST API (Version 2) plugin https://wordpress.org/plugins/rest-api/
    * OAuth 1 plugin https://github.com/WP-API/OAuth1 
    * Fill WPRESTAPI.json by own values (WP Server, consumer keys,...)
* for WooCommerce consuming
    * Woocommerce plugin and enabling Woocommerce API in Woocommerce setting
    * Fill WOORESTAPI.json by own values (WP Server, consumer keys,...)
    
####Documentation:
* Woocommmerce REST API             https://woothemes.github.io/woocommerce-rest-api-docs/
* WP REST API                       http://wp-api.org/
* WordpressP REST API(version 2)    http://v2.wp-api.org/
* OAuth1                            http://oauth1.wp-api.org/

####Settings:
* for Wordpress consuming (WP REST API)
    * file **WPRESTAPI.json**
    
        ```    
        {"fieldCount":13,"values":["Server","Port","RestAPI","WPOauth","HTTPS","ConsumerKey","ConsumerKeySecret","URL","AccessToken","AccessTokenSecret","WPUser","WPPassword","Expirated",
         "[your-WP-server]","[WP-port]","wp-json","oauth1",[WP-secure],"[your-consumer-key]","[your-consumer-secret-key]","[WP-REST-API-Url]","","","[your-WP-user]","[your-WP-pwd]",null]}
        ``` 
        * [WP-port] - if empty string then is taken 80 as default value
        * [WP-secure] - true/false
        * [WP-REST-API-Url] - http[s]://[your-WP-server]/wc-api/[Woocommerce API version]/
        * [your-consumer-key], [your-consumer-secret-key] ->  these keys are generated by Oauth1 plugin
        * AccessToken, AccessTokenSecret,Expired - will be complemented after the authentication
        * [your-WP-user],[your-WP-pwd] - Wordpress user with corresponding capabilities ( read-.., edit-..,create-..)
    
* for Woocommerce consuming (Woocommerce API)
    * file **WOORESTAPI.json**
    
        ```    
        {"fieldCount":14,"values":["Server","Port","RestAPI","Oauth","HTTPS","ConsumerKey","ConsumerKeySecret","URL","AccessToken","AccessTokenSecret","WPUser","WPPassword","Expirated","RESTAPIVersion",
         "[your-WP-server]","[WP-port]","wc-api","",[WP-secure],"[your-consumer-key]","[your-consumer-secret-key]","[WP-REST-API-Url]","","","","","","[Woocommerce API version]"]}
        ``` 
        * [WP-port] - if empty string then is taken 80 as default value
        * [WP-secure] - true/false
        * OAuth - not used
        * [WP-REST-API-Url] - http[s]://[your-WP-server]/wc-api/[Woocommerce API version]/
        * [your-consumer-key], [your-consumer-secret-key] ->  these keys are generated by Oauth1 plugin
        * AccessToken, AccessTokenSecret,Expired - not used
        * WPUser, WPPassword - not used


## LICENSE

[The MIT License](https://github.com/wenzhixin/multiple-select/blob/master/LICENSE)


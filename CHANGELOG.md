## Changelog

##2016-01-01
* [bug] insufficiently freeing WPRestAPI.Parameters (a memory leak) 
* [enh] added support of new Oauth1 plugin version (0.2.1)
	* Oauth1 plugin version 0.2.1 and previous Oauth1 plugin version 0.1 uses different hash keyin the last third flow of authentification:

	 Oauth1 version 0.1 uses only [consumer secret key]

	 Oauth1 version 0.2.1 uses [consumer secret key]&[request secret key]

	* Oauth1 plugin version 0.1 has bug in the file *lib/class-wp-json-authentication.php* in the function:
 
		_**public function get_consumer( $key )**_ 

		instead of 

		    $consumers = $query->query( array(
			'post_type' => 'json_consumer',
			'post_status' => 'any',
			'meta_query' => array(
				array(
					'meta_key' => 'key',
					'meta_value' => $key,
				),
				array(
					'meta_key' => 'type',
					'meta_value' => $this->type,
				),
			),
		) );
		
		has to be

		    $consumers = $query->query( array(
			'post_type' => 'json_consumer',
			'post_status' => 'any',
			'meta_query' => array(
				array(
					'key' => 'key',
					'value' => $key,
				),
				array(
					'key' => 'type',
					'value' => $this->type,
				),
			),
		) );
	
	* due the change of functionality of Oauth1 plugin you should check your version and write down  Oauth1 plugin version into **WPRESTAPI.json** (or **WOORESTAPI.json**)

##2016-01-02
	* [change] the creation of aNameValuePairs array by using mormot subroutines	 	

		 


/**
* This module provides a method to process DX tracking files
**/
component {

	// Module Properties
    this.modelNamespace			= 'dxukcfml';
    this.cfmapping				= 'dxukcfml';
    this.parseParentSettings 	= true;

	/**
	 * Configure
	 */
	function configure(){

		// Skip information vars if the box.json file has been removed
		if( fileExists( modulePath & '/box.json' ) ){
			// Read in our box.json file for so we don't duplicate the information above
			var moduleInfo = deserializeJSON( fileRead( modulePath & '/box.json' ) );

			this.title 				= moduleInfo.name;
			this.author 			= moduleInfo.author;
			this.webURL 			= moduleInfo.repository.URL;
			this.description 		= moduleInfo.shortDescription;
			this.version			= moduleInfo.version;

		}

		// Settings
		settings = {
				'api_key' : ''
			,	'resultsfilePath' : ''
		};
	}

	function onLoad(){
		binder.map( "fileManager@dxukcfml" )
			.to( "#moduleMapping#.models.fileManager" )
			.asSingleton()
			.initWith(
				resultsfilePath = settings.resultsfilePath
			);
	}

}
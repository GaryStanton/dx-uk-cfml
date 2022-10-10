# DX UK CFML

DX UK CFML provides a method to process DX tracking files.

## Examples
Check out the `/examples` folder for an example implementation.

## Usage
The DX UK CFML wrapper consists of a single model to process the results files provided by the DX software.

### Standalone
```cfc
DXConsignments = new models.fileManager(
		resultsfilePath = "path/to/folder"
	,	dateRange = "#DateFormat(dateadd('m', -1, Now()), 'mm/dd/yyyy')#,#DateFormat(Now(), 'mm/dd/yyyy')"
);
```

### ColdBox
```cfc
DXFiles 	= getInstance("fileManager@dxukcfml");
```
alternatively inject it directly into your handler
```cfc
property name="DXFiles" inject="fileManager@dxukcfml";
```

When using with ColdBox, you'll want to insert your filesystem details into your module settings:

```cfc
dxukcfml = {
		resultsfilePath	= getSystemSetting("RM_RESULTSFILEPATH", "")
}
```

### Retrieve consignment data
```cfc
fileList = DXFiles.getFileList();
```

During processing, files are copied over to an internal folder for storage. (defaults to `/store`). You may remove files from their original location with the `deleteFiles` argument.

```cfc
fileContents = DXFiles.processFiles(
		dateRange 		= '2021-01-01,2021-01-31'
	,	deleteFiles 	= false
);
```


## Author
Written by Gary Stanton.  
https://garystanton.co.uk
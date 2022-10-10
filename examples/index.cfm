<!doctype html>

<cfscript>
	setting requesttimeout="600";
	formName = 'frmRetrieveFiles';

	if (StructKeyExists(Form, 'fileList')) {
		DXExportFiles = new models.fileManager(
				resultsfilePath = Form['#formName#_filefolder']
		);

		fileList = DXExportFiles.filterFileList(
				dateRange = Form['#formName#_daterange']
		);
	}


	if (StructKeyExists(Form, 'fileContents')) {
		DXExportFiles = new models.fileManager(
				resultsfilePath = Form['#formName#_filefolder']
		);

		fileContents = DXExportFiles.processFiles(
				dateRange = Form['#formName#_daterange']
			,	deleteFiles = false
		);
	}
</cfscript>

<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

		<!--- Date range --->
		<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
		<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

		<title>DX UK CFML examples</title>
	</head>

	<body>
		<cfoutput>
			<div class="container">
				<h1>DX UK CFML examples</h1>
				<hr>

				<div class="row">
					<div class="col-sm-12">
						<div class="mr-12">
							<h2>Export files</h2>
							<p>When creating shipments via DX, the software creates export files containing order references and tracking numbers. Enter filesystem details in the index.cfm to test the following fuctionality.</p>

							<form method="POST">
								<div class="form-group row">
									<label for="#formName#_filefolder" class="col-sm">DX file location</label>
									<div class="col-sm">
										<input type="text" required="true" class="form-control" id="#formName#_filefolder" name="#formName#_filefolder" aria-describedby="filefolder" placeholder="c:\dxfiles\" value="#StructKeyExists(Form, '#formName#_filefolder') ? Form['#formName#_filefolder'] : ''#">
									</div>
								</div>

								<div class="form-group row">
									<label for="#formName#_daterange" class="col-sm">Date range</label>
									<div class="col-sm">
										<input type="text" class="form-control" id="#formName#_daterange" name="#formName#_daterange" aria-describedby="daterange">
									</div>
								</div>

								<div class="input-group">
									<div class="">
										<button type="submit" class="btn btn-primary" type="button" name="fileList">View file list</button>
										<button type="submit" class="btn btn-primary" type="button" name="fileContents">View file contents</button>
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>

				<cfif structKeyExists(Variables, 'fileList')>
					<hr />
					<cfdump var="#fileList#">
				</cfif>

				<cfif structKeyExists(Variables, 'fileContents')>
					<hr />
					<cfdump var="#fileContents#">
				</cfif>
			</div>

			<script>
				$(function() {
					$('input[name="#formName#_daterange"]').daterangepicker({
						"startDate": "#DateFormat(StructKeyExists(Form, '#formName#_daterange') ? listFirst(Form['#formName#_daterange']) : dateadd('m', -1, Now()), 'mm/dd/yyyy')#",
						"endDate": "#DateFormat(StructKeyExists(Form, '#formName#_daterange') ? listLast(Form['#formName#_daterange']) : Now(), 'mm/dd/yyyy')#",
						"locale": {
							"separator": ",",
							"format": "MM-DD-YYYY"
						}
					});
				});
			</script>
		</cfoutput>
	</body>
</html>
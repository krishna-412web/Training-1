<cfoutput>
	<cfif structKeyExists(form,"submit")>
		<cfif structKeyExists(form, "file")>
    			<cfif isDefined("form.file") AND len(trim(form.file)) gt 0>
        			<cfset uploadDir = expandPath('./uploads/')>        
				<cfif not directoryExists(uploadDir)>
            				<cfdirectory action="create" directory="#uploadDir#">
        			</cfif>
        			<cffile action="upload"
               	 			filefield="file"
                			destination="#uploadDir#"
                			nameConflict="makeunique">
        
       				<cfset uploadedFileName = cffile.serverFile>
				<cfset extension=cffile.SERVERFILEEXT>
				<cfset supported="gif/jpg/png">
				<cfset fileSize=cffile.FILESIZE/1024>
				<cfset memoryMessage="Memory  Validation t\tOK">
				
				<cfif ListContains(supported,extension,"/")>
					 <cfif fileSize LTE 1024>
						File <strong>#uploadedFileName#</strong> uploaded successfully!<br>
						<link href="./css/styles.css">				
						<img src="./uploads/#uploadedFileName#" alt="try"/>
						<form action="result.cfm" method="post">
							<input type="hidden" name="imgpath" value="#uploadedFileName#">
							<input type="hidden" name="imgname" value="#form.imgname#">
							<input type="hidden" name="imgdesc" value="#form.imgdesc#">
							<button  id="sps" type="submit" name="submit">#form.imgname#</button>
						</form>
					<cfelse>
						*file size should be less than or equal to 1mb<br>			
					</cfif>
				<cfelse>
					*file format not supported(allowed formats-jpg,gif,png)<br>
				</cfif>
				<!---<cfdump var="#uploadedFileName#">--->
				<cfdump var="#cffile#">
    				<cfelse>
       		 		<p>No file was uploaded.</p>
    			</cfif>
		<cfelse>
    			<p>No file data received.</p>
		</cfif>
	</cfif>
</cfoutput>
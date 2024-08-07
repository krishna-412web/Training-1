<cfform action="" method="post" enctype="multipart/form-data">
	<div>
		<label for="imgname">Enter Image Name:</label>
		<cfinput type="text" id="imgname" name="imgname" placeholder="Myphoto" message="Image name required" required >
	</div>
	<div>
		<label for="file">Attach Image File:</label>
		<cfinput type="file" id="file" name="file" placeholder="Add file" message="Image not added" accept="image/*" required>
	</div>
	<div>
		<label for="imgdesc">Enter Image description:</label>
		<cftextarea type="text" id="imgdesc" name="imgdesc" placeholder="I was sitting on a chair." message="Image description not added" required>			</cftextarea>
	</div>
	
	<input type="submit" name="submit" value="submit"/>
</cfform>



<cfif NOT isNull(form.submit)>
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
	
			<cfoutput><br>#extension#<br></cfoutput>
			<cfoutput>#fileSize#<br></cfoutput>
			<cfoutput>#form.imgname#<br></cfoutput>
			<cfoutput>#form.imgdesc#<br></cfoutput>
	
			<cfif ListContains(supported,extension,"/")>
				 <cfif fileSize LTE 1024>
					        <cfoutput>File <strong>#uploadedFileName#</strong> uploaded successfully!<br></cfoutput>
						<style>
							img {
								height: 10vh;
								width: 5vw;
							}
							/*Special Submit Button*/
							#sps {
								background-color: #ffffff;
								border:0;
								outline: 0;
							}
						</style>
				
					<cfoutput><img src="./uploads/#uploadedFileName#" alt="try"/></cfoutput>
					<cfform action="result.cfm" method="post">
						<cfinput type="hidden" name="imgpath" value="#uploadedFileName#">
						<cfinput type="hidden" name="imgname" value="#form.imgname#">
						<cfinput type="hidden" name="imgdesc" value="#form.imgdesc#">
						<button  id="sps" type="submit" name="submit"><cfoutput>#form.imgname#</cfoutput></button>
					</cfform>
				<cfelse>
					<cfoutput>*file size should be less than or equal to 1mb<br></cfoutput>			
				</cfif>
			<cfelse>
				<cfoutput>*file format not supported(allowed formats-jpg,gif,png)<br></cfoutput>
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


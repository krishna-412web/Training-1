<cfset uploadDir = expandPath('./temp/')>        
<cfif not directoryExists(uploadDir)>
      <cfdirectory action="create" directory="#uploadDir#">
</cfif>
<cffile action="upload"
        filefield="profile"
        destination="#uploadDir#"
        nameConflict="makeunique">
<cfset local.imgPath="#uploadDir##cffile.serverFile#">
<cfset local.uploadedFileExt = cffile.SERVERFILEEXT>

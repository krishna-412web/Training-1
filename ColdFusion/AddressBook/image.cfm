<cfset uploadDir = expandPath('./images/')>        
<cfif not directoryExists(uploadDir)>
      <cfdirectory action="create" directory="#uploadDir#">
</cfif>
<cffile action="upload"
        filefield="profile"
        destination="#uploadDir#"
        nameConflict="makeunique">
<cfset uploadedFileName = cffile.serverFile>
<cfset imgPath="./images/#uploadedFileName#">


<cfset cdate=now()>
<cfset cyear=Year(cdate)>
<cfset cmonth=Month(cdate)>
<cfset d = now().setDay(0)+DaysInMonth(now())>


<cfoutput>
	#DateFormat(cdate,"dd-mm-yyyy")#<br>
	#DateFormat(cdate,"mm")#<br>#DateFormat(cdate,"mmmm")#<br>

	<cfloop from="#now()#" to="#now()-7#" step="#CreateTimeSpan(-1,0,0,0)#" index="n">
		<cfset check=DateFormat(n,"dddd")>
		<cfif check EQ "Friday">
			#DateFormat(n,"dd-mm-yyyy-")# #check#<br>		
		</cfif>
	</cfloop>

	#DateFormat(d,"dd-mm-yyyy")#<br><br>
	
	<cfloop from="#now()#" to="#now()-5#" step="#CreateTimeSpan(-1,0,0,0)#" index="n">
		<cfoutput>#DateFormat(n,"dd-mm-yyyy-")#<span class="week">#DateFormat(n,"dddd")#</span><br></cfoutput>
	</cfloop>

	<script src="./js/script.js"></script>
</cfoutput>


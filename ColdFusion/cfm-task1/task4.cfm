<cfset cdate=now()>
<cfset cyear=Year(cdate)>
<cfset cmonth=Month(cdate)>
<cfset d = now().setDay(0)+DaysInMonth(now())>


<cfoutput>#DateFormat(cdate,"dd-mm-yyyy")#<br>
#DateFormat(cdate,"mm")#<br>#DateFormat(cdate,"mmmm")#<br></cfoutput>

<cfloop from="#now()#" to="#now()-7#" step="#CreateTimeSpan(-1,0,0,0)#" index="n">
	<cfset check=DateFormat(n,"dddd")>
	<cfif check EQ "Friday">
		<cfoutput>#DateFormat(n,"dd-mm-yyyy-")# #check#<br></cfoutput>		
	</cfif>
</cfloop>

<cfoutput>#DateFormat(d,"dd-mm-yyyy")#<br></cfoutput>

<cfoutput><br></cfoutput>
	
<cfloop from="#now()#" to="#now()-5#" step="#CreateTimeSpan(-1,0,0,0)#" index="n">
	<cfoutput>#DateFormat(n,"dd-mm-yyyy-")#<span class="week">#DateFormat(n,"dddd")#</span><br></cfoutput>
</cfloop>



<script>
let e= document.getElementsByClassName("week");
for(let i=0;i<e.length;i++)
{
	switch(e[i].innerHTML)
	{
		case "Sunday":e[i].style.color="red";
		break;

		case "Monday":e[i].style.color="green";
		break;

		case "Tuesday":e[i].style.color="orange";
		break;

		case "Wednesday":e[i].style.color="yellow";
		break;

		case "Thursday":e[i].style.color="black";
				e[i].style.fontWeight="bold";
		break;

		case "Friday":e[i].style.color="blue";
		break;

		case "Saturday":e[i].style.color="red";
				e[i].style.fontWeight="bold";
		break;
	}
}
</script>


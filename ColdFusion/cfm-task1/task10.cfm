<!---<cfquery name="setData" datasource="test1">--->
<!---	CREATE TABLE NAMES(firstname VARCHAR(15),secondname VARCHAR(15));--->
<!---</cfquery>--->

<!---<cfquery name="alterTable" datasource="test1">
	ALTER TABLE NAMES CHANGE secondname lastname VARCHAR(15);
</cfquery>--->

<!---<cfquery name="InsertData" datasource="test1">
	INSERT INTO NAMES(firstname,lastname) 
	VALUES
	("Krishna","Renjith"),
	("Jake","Perellta"),
	("Amy","Santiago"),
	("Terry","Jeffords"),
	("Raymond","Holt"),
	("Gina","Tribbiani"),
	("Joey","Tribbiani"),
	("Charles","Xavier"),
	("Jeralt","Peter"),
	("Giddon","Holtsting");

</cfquery>--->


<!---<cfloop query="showData">
	<cfoutput>#firstname &" "& lastname # <br></cfoutput>
</cfloop>--->

<!---****************************************************************************************** --->

<cfquery name="showData" datasource="test1"> SELECT firstname,lastname from NAMES;</cfquery>

<cfform action="" method="post">
	<label for="num">Enter Number:</label>
	<input type="text" id="num" name="num" placeholder="(1-10) allowed">
	<input type="submit" name="submit" value="submit"/>
</cfform>

<cfif NOT isNull(form.submit)>
	<cfif form.num GTE 1 AND form.num LTE 10>
		<table border="2px solid black">
			<tr>
				<th>FirstName</th>
				<th>LastName</th>
			</tr>
			<cfloop query="showData">
				<cfoutput>
					<tr>
						<td>#firstname#</td>
						<td>#lastname#</td>
					</tr>
				</cfoutput>
			</cfloop>
		</table>
		<cfset firstName=showData.firstname[form.num]>
		<cfoutput><br></cfoutput>
		<cfoutput>Row :#form.num# <br> FirstName:#firstName#</cfoutput>
		
	<cfelse>
		<cfoutput>ENTER NUMBERS FROM 1 TO 10</cfoutput>
	</cfif>
</cfif>

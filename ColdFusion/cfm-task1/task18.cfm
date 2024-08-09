<cfset info=QueryNew("id,name,email","Integer,Varchar,Varchar",
	[ [1,"John Doe","johnDoe@gmail.com"],
	  [2,"Jane Smith","janeSmith@gmail.com"],
	  [3,"Robin Smith","robe@gmail.com"]
	])>

<cfoutput>
	<style>
		th,td { padding: 5px;
		}
	</style>
	<table border="1px solid black">
		<tr>
			<th>ID</th>
			<th>NAME</th>
			<th>EMAIL</th>
		</tr>
		<cfloop query="info">
			<tr>
				<td>#id#</td>
				<td>#name#</td>
				<td>#email#</td>
			</tr>
		</cfloop> 
	</table>
</cfoutput>
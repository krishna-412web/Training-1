<cfoutput>
	<cfform action="" method="post" id="form1">
		<div>
			<label for="num">Enter Number:</label>
			<cfinput type="text" id="num" name="num" message="*this field is required" required>
		</div>
		<input type="submit" name="submit" value="submit">
	</cfform>
	<script>
		let form=document.getElementById("form1");
		let number=document.getElementById("num");
		form.addEventListener("submit", (event) => {
			let valid = true;
			if( isNaN(num.value))
			{
				valid = false;
				alert("*only numbers are allowed");
				number.value="";
			}
			
			if(!valid)
				event.preventDefault();
			else
				alert("!!FORM SUBMITTED!!")
			
		})
	</script>
</cfoutput>

<cfparam name="form.submit" default="">
<cfparam name="form.num" default="0">

<cfif NOT isNull(form.submit)>

	<cfoutput>
		<style>
			.odd { color:blue; }
			.even { color:green; }
		</style>
		<cfset n= form.num>

		<cfloop from="1" to="#n#" index="i">
			<cfif i mod 2 EQ 0>
				<cfoutput><span class="even">#i#</span><br></cfoutput>
			<cfelse>
				<cfoutput><span class="odd">#i#</span><br></cfoutput>
			</cfif>
		</cfloop>
 
	</cfoutput>
	
</cfif>
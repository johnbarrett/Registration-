
			
<cfparam name="name" default="">
<cfparam name="form.email_address" default="">
<cfparam name="form.phone" default="">
<cfparam name="form.password"  default="">
<cfparam name="form.location" default="">
<cfparam name="form.user_name" default="">
<cfparam name="form.pass" default="">



	<cfquery name="DupCheck" datasource="#Application.dataSource#">
		SELECT *
		FROM  email_alerts 
		WHERE email_address = <cfqueryparam cfsqltype="cf_sql_varchar" value="#Form.email_address#" />
	</cfquery>

<!--- If our query shows a email match than using recordCount we can tell the user that his email address already exists in our database --->
<cfif DupCheck.recordCount GT "0">

    Your email is already Listed in our mailing list <br />
     Please go back to the <a href="subscribe.cfm">subscribe form</a> and try again.
   <!--- If our recordCount is not greater than "0" we continue on and process the new email address --->

   <cfelse>


    
	 <!--- Insert the new record --->
		<cfquery name="AddUser" datasource="#Application.dataSource#">
		   INSERT INTO email_alerts (first_name, last_name,email_address, phone, location, user_name, pass, date)
		  VALUES ('#form.first_name#', '#form.last_name#','#form.email_address#', '#form.phone#', '#form.location#', '#form.user_name#', '#form.pass#', #CreateODBCDateTime(Now())#)
		   <cfqueryparam value="#form.first_name#" cfsqltype="varchar">,
		   <cfqueryparam value="#form.last_name#" cfsqltype="varchar">,
		   <cfqueryparam value="#form.email_address#" cfsqltype="varchar">,
		   <cfqueryparam value="#form.phone#" cfsqltype="varchar">,
		   <cfqueryparam value="#form.location#" cfsqltype="varchar">
		   <cfqueryparam value="#form.user_name#" cfsqltype="varchar">
		   <cfqueryparam value="#form.pass#" cfsqltype="varchar">
		
		</cfquery>
		
	<cfoutput>
        Thank you #Name#,<br />
        Your email address [#email_address#] Has been entered into our mailing list. You'll receive the next mailing!
      </cfoutput>
</cfif>

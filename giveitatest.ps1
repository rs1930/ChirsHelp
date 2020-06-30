#This script is used to compare a list of users vs a selected AD.
#This imports your csv. We're looking for a Name,Email format.
$list = Import-Csv c:\replace\path\here\chris

#This is used later to authenticate you to whatever server you fillout below.
$ADServer = Replace.this.with.your.AD.server.FQDN

#This will cycle through each line in the imported csv and query active directory for that user.

ForEach ($line in $list) {
    #This is setting the get_user value to the Get-ADUser command along with the variables. 
    $get_user = Get-ADUser -Filter "(Name -eq '$line.Name') -And (Mail -eq '$line.Email')" -Server $ADServer
    #This is checking to see if $get_user returns null, if the query returns something then there should be something within the $get_user variable.
    #I don't know if this will work if there isnt a user with that name/email combo though. I woudl have to run the above command to check.
    if ($get_user -ne $null) {
        #This is appending the file selected below, I don't know powershell escapes variables within quotes. I haven't used powershell in a while
        #but for refrence in bash the below would not result in the variables being escaped/expanded. 
        Add-Content c:\what\ever\you\want\chris.txt "User $line.Name with a Email of $line.Email has been found within Active Directory."
    }else {
        #Same as above no clue if this will work as intended.
        Add-Content c:\what\ever\you\want\chris.txt "User $line.Name with a Email of $line.Email has not been found within Active Directory."
    }


}


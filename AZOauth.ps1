
$logo = @('

   ▄▄▄      ▒███████▒ ▒█████   ▄▄▄       █    ██ ▄▄▄█████▓ ██░ ██ 
  ▒████▄    ▒ ▒ ▒ ▄▀░▒██▒  ██▒▒████▄     ██  ▓██▒▓  ██▒ ▓▒▓██░ ██▒
  ▒██  ▀█▄  ░ ▒ ▄▀▒░ ▒██░  ██▒▒██  ▀█▄  ▓██  ▒██░▒ ▓██░ ▒░▒██▀▀██░
  ░██▄▄▄▄██   ▄▀▒   ░▒██   ██░░██▄▄▄▄██ ▓▓█  ░██░░ ▓██▓ ░ ░▓█ ░██ 
   ▓█   ▓██▒▒███████▒░ ████▓▒░ ▓█   ▓██▒▒▒█████▓   ▒██▒ ░ ░▓█▒░██▓
   ▒▒   ▓▒█░░▒▒ ▓░▒░▒░ ▒░▒░▒░  ▒▒   ▓▒█░░▒▓▒ ▒ ▒   ▒ ░░    ▒ ░░▒░▒
    ▒   ▒▒ ░░░▒ ▒ ░ ▒  ░ ▒ ▒░   ▒   ▒▒ ░░░▒░ ░ ░     ░     ▒ ░▒░ ░
    ░   ▒   ░ ░ ░ ░ ░░ ░ ░ ▒    ░   ▒    ░░░ ░ ░   ░       ░  ░░ ░
        ░  ░  ░ ░        ░ ░        ░  ░   ░               ░  ░  ░


    Creator: https://securethelogs.com / @securethelogs       

')

$logo

try { $test = Get-AzureADUser -Top 1 ; Write-Host " [*] Connected to Azure AD ..." -ForegroundColor Green }catch{ Write-Host " Please connect to AzureAD Using the AzureAD Module ..." -ForegroundColor Red ; exit}
 
Write-Host " [*] Getting SPNs with Oauth Grants ..."

$sps = @(Get-AzureADServicePrincipal  | Select-Object * | Where-Object {$_.oauth2Permissions -ne $null})

Write-Host " [*] Pulling Details ..."
Start-Sleep -Seconds 2


Write-Output ""
Write-Output ""

foreach ($sp in $sps){

Write-Host " [*] Application Details ..."

Write-Output ""

Write-Host "     PublisherName: " -NoNewline ; Write-Host $sp.PublisherName -ForegroundColor Green
Write-Host "     DisplayName: " -NoNewline ; Write-Host $sp.DisplayName -ForegroundColor Green
Write-Host "     AppID: " -NoNewline ; Write-Host $sp.AppID -ForegroundColor Gray
Write-Host "     ReplyURLs: " -NoNewline ; Write-Host $sp.ReplyUrls -ForegroundColor Gray

Write-Output ""

$oauth = @(Get-AzureADServicePrincipalOAuth2PermissionGrant -ObjectId $sp.ObjectId | Select-Object *)

Write-Host " [*] OAuth Permissions ..."

Write-Output ""

    foreach ($oa in $oauth){

    $permc = "Green"
    
        try { $user = (Get-AzureADUser -ObjectId $oa.PrincipalId).UserPrincipalName } catch {}

         Write-Host "     User: " -NoNewline ; Write-Host $user -ForegroundColor Green
         Write-Host "     Permissions: " -NoNewline ; Write-Host $oa.Scope -ForegroundColor Red
         Write-Host "     Consented: " -NoNewline ; Write-Host $oa.ConsentType -ForegroundColor Gray
    
         Write-Output ""
    
    }

    Write-Host "                                    -------------"

    Write-Output ""
    Write-Output ""

    


}



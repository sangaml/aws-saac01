<powershell> 
Start-Transcript; 
Import-Module ServerManager; 
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName 'IIS-WebServerRole', 'IIS-WebServer', 'IIS-ManagementConsole';
</powershell>

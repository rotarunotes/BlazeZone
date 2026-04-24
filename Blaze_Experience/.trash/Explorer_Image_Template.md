<%*
const { exec } = require('child_process');
exec(`powershell -Command "
  $shell = New-Object -ComObject Shell.Application;
  $shell.Open('C:\\Users\\user\\Fold\\BlazeZone\\Blaze_Experience\\Setup_Archive\\Viewable\\Image');
  Start-Sleep -Milliseconds 800;
  $shell.Open('C:\\Users\\user\\Pictures\\Screenshots');
  Start-Sleep -Milliseconds 800;
  $shell.Open('C:\\Users\\user\\Downloads');
"`);
%>
####Load PowerCLI Module####
#Load VMware PowerCLI Core Module####
Import-Module -Name VMware.VimAutomation.Core -ErrorAction SilentlyContinue
####Define#####
$vcenter = "vcenter address/fqdn"

####Form Start####
Add-Type -AssemblyName System.Windows.Forms
$Form = New-Object system.Windows.Forms.Form
$Form.Text = "VM Console Launcher"
$Form.TopMost = $true
$Form.Width = 260
$Form.Height = 195

$label1 = New-Object system.windows.Forms.Label
$label1.Text = "Username: "
$label1.AutoSize = $true
$label1.Width = 25
$label1.Height = 10
$label1.location = new-object system.drawing.point(21,24)
$label1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label1)

$label1 = New-Object system.windows.Forms.Label
$label1.Text = "Username: "
$label1.AutoSize = $true
$label1.Width = 25
$label1.Height = 10
$label1.location = new-object system.drawing.point(21,24)
$label1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label1)

$label2 = New-Object system.windows.Forms.Label
$label2.Text = "Password: "
$label2.AutoSize = $true
$label2.Width = 25
$label2.Height = 10
$label2.location = new-object system.drawing.point(19,56)
$label2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($label2)

$username_tb = New-Object system.windows.Forms.TextBox
$username_tb.Width = 100
$username_tb.Height = 20
$username_tb.location = new-object system.drawing.point(103,25)
$username_tb.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($username_tb)

$password_tb = New-Object System.Windows.Forms.MaskedTextBox
$password_tb.Width = 100
$password_tb.Height = 20
$password_tb.PasswordChar = '*'
$password_tb.location = new-object system.drawing.point(104,57)
$password_tb.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($password_tb)

$button1 = New-Object system.windows.Forms.Button
$button1.Text = "Login"
$button1.Width = 60
$button1.Height = 30
$button1.Add_Click({
#add here code triggered by the event
Connect-VIServer $vcenter -username $username_tb.Text -Password $password_tb.Text
$selection = Get-VM | Out-GridView -OutputMode Multiple
$selection | foreach {Open-VMConsoleWindow $_ }
})
$button1.location = new-object system.drawing.point(22,101)
$button1.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($button1)

$button2 = New-Object system.windows.Forms.Button
$button2.Text = "Quit"
$button2.Width = 60
$button2.Height = 30
$button2.Add_Click({
$Form.close()
})
$button2.location = new-object system.drawing.point(103,100)
$button2.Font = "Microsoft Sans Serif,10"
$Form.controls.Add($button2)

[void]$Form.ShowDialog()
$Form.Dispose()
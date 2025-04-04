#用Form写的简易UI，可以让ci提供ui api，优化下（Form实在太丑辣）

Add-Type -assembly System.Windows.Forms
$main_form = New-Object System.Windows.Forms.Form
$main_form.Text ='GUI for my PowerShell script'
$main_form.Width = 600
$main_form.Height = 400

$Label = New-Object System.Windows.Forms.Label
$Label.Text = "AD users aaaaaaaaaaaaaaaaaaaaaaaa"
# Set font family name and size
$Label.Font = 'Microsoft Sans Serif,14'
# Set element position based on pixels from left and top of form
$Label.Location = New-Object System.Drawing.Point(0,10)
$Label.AutoSize = $true

$button = New-Object System.Windows.Forms.Button
$button.Font = 'Microsoft Sans Serif,14'
$button.Text = "Click me!"
$button.Location = New-Object System.Drawing.Point(0,40)
$button.AutoSize = $true
$button.PerformClick({
    "hello"
})    
$main_form.Controls.Add($Label)
$main_form.Controls.Add($button)
$main_form.ShowDialog()
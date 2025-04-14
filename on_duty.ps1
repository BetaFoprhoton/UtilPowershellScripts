function Display-Name {
    param (
        $nameToDisplay,
        $stringToOverride
    )

    Add-Type -assembly System.Windows.Forms
    $mainForm = New-Object System.Windows.Forms.Form
    $mainForm.Text ='GUI'
    $mainForm.Width = 600
    $mainForm.Height = 400

    $Label = New-Object System.Windows.Forms.Label
    $Label.Text = "今天值日的是： " + $nameToDisplay + "，请更换名牌后签到"
    # Set font family name and size
    $Label. Font = 'Microsoft Sans Serif,18'
    # Set element position based on pixels from left and top of form
    $Label.Location = New-Object System.Drawing.Point(0,0)
    $Label.AutoSize = $true

    $button = New-Object System.Windows.Forms.Button
    $button. Font = 'Microsoft Sans Serif,18'
    $button.Text = "签到"
    $button.Location = New-Object System.Drawing.Point(0,40)
    $button.AutoSize = $true
    $button.DialogResult = [System.Windows.Forms.DialogResult]::OK

    $mainForm.AcceptButton = $button
    $mainForm.Controls.Add($Label)
    $mainForm.Controls.Add($button)

    #$ws = New-Object -ComObject WSript.Shell


    $result = $mainForm.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $title = 'Confirm'
        $question = '确定？'
        $choices = '&Yes', '&No'

        $decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
        if ($decision -eq 0) {
            Write-Host 'Your choice is Yes.'
            Out-File name_list.txt -InputObject $logString
        }
        else {
            Display-Name $nameToDisplay
        }
    }
}


$today = Get-Date -Format "yyyy/dd/MM"

$lastDay = ""

$newNameList = ""

$nameList = Get-Content name_list.txt

$dutyRow = ($nameList[0] -split " ").Lenth + 1

if ((($nameList[-1]  -split " ")[$dutyRow]) -eq $today) {
    Show (($nameList[0]  -split " ")[$dutyRow])
} else {
    if (($nameList[-1]  -split " ").Length -eq ($nameList[0]  -split " ").Length) {
        $dutyRow += 1
    }
}
$logString = ""
$dutyName = ""
$selectedFlag = $false
$hasSigned = $false
foreach ($_ in $nameList) {

    if ($selectedFlag -eq $true) {
        $logString += $_ + "`n"
    } else {

        $name = ($_ -split " ")[0]

        $day = ($_ -split " ")[$dutyRow]

        if ($day -eq $null) {
           $dutyName = $name
           $logString += $_ + " " + $today + "`n"
           $selectedFlag = $true
        } else {
           if ($day -eq $today) {
               $dutyName = $name
               $logString += $_  + "`n"
               $selectedFlag = $true
               $hasSigned = $true
           } else {
               $logString += $_  + "`n"
           }
        }
    }
}

#$logString
if ($hasSigned -eq $false) {
    Display-Name $dutyName $logString
} else {
    "今天值日的是： " + $dutyName + "`n状态：已签到`n日期：" + $today
}
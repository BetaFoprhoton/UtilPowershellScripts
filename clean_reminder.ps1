function Show {
    param (
        $stringToShow
    )
    "清洁：" + $stringToShow
    $fullText = ("今天做清洁的是：" + $stringToShow + "`n请记得留下来做清洁。")

    Add-Type -assembly System.Windows.Forms
    $mainForm = New-Object System.Windows.Forms.Form
    $mainForm.Text ="提醒"
    $mainForm.Width = 600
    $mainForm.Height = 400

    $label = New-Object System.Windows.Forms.Label
    $label.Text = $fullText
    $label. Font = 'Microsoft Sans Serif,18'
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(0, 10)
    $mainForm.Controls.Add($Label)

    Add-Type -AssemblyName System.speech
    $syn = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $syn.Rate = 1.5
    $syn.Volume = 80
    $syn.Speak($fullText)

    $mainForm.ShowDialog()
    
  
}

$currentltDay = Get-Date -Format "dddd"
"今天：" + $currentltDay
$day = (Get-Content -Path .\week.txt)[0]
"上次缓存运行：" + $day
$isDoubleWeek = (Get-Content -Path .\week.txt)[1]

if (($currentltDay -eq "星期一") -and ($day -eq "星期日")) {
    $isDoubleWeek = ! $isDoubleWeek
    "单双周轮换"
}

if ($isDoubleWeek) { "双周" } else { "单周" }
 
Out-File week.txt -InputObject $currentltDay
Add-Content week.txt -value $isDoubleWeek

if ($currentltDay -eq "星期一") {
    Show "走读"
}

if ($isDoubleWeek -eq $False){ 
    Switch ($currentltDay) {
        "星期二" { Show "第2组, 三金西瓜霜"}
        "星期三" { Show "第3组, 吴彦组"}
        "星期四" { Show "第4组, A组"}
        "星期五" { Show "第5组, 两年半"}
        "星期日" { Show "第1组, 格斗准备组"}
    }
} else {
    Switch ($currentltDay) {
        "星期二" { Show "第7组, 基因虫组"}
        "星期三" { Show "第8组, 高考调研组"}
        "星期四" { Show "第9组, China Town(CT)"}
        "星期五" { Show "第10组, 睡睡冰"}
        "星期日" { Show "第6组, 二元一次方程组"}
    }
}

Start-Sleep -Seconds 180
exit
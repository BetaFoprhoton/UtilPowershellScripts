Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
 

public class Mouse {
    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(long dwFlags, long dx, long dy, long cButtons, long dwExtraInfo);
 
    public const int MOUSEEVENTF_MOVE = 0x0001;
    public const int MOUSEEVENTF_LEFTDOWN = 0x0002;
    public const int MOUSEEVENTF_LEFTUP = 0x0004;
    public const int MOUSEEVENTF_RIGHTDOWN = 0x0008;
    public const int MOUSEEVENTF_RIGHTUP = 0x0010;
    public const int MOUSEEVENTF_ABSOLUTE = 0x8000;
}
"@


function Type-String {
    param(
        [string]$stringToType
    )
    $stringToType | ForEach-Object {
        $shell.SendKeys($_)
    }
}

[void][reflection.assembly]::Load('System.Windows.Forms, Version=2.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
 
function Click-AtPosition($x, $y) {
    # Move the mouse to the specified position
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    
    # Perform the click
    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
    Start-Sleep -Milliseconds 100
    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
}

try {
    $note = Get-Process -name "EasiNote" -ErrorAction Stop 
} catch {
    exit
}

for ($i = 0; $i -lt 3; $i++) {
    #提示音，可以写个库
    [Console]::Beep(1046, 300)
    [Console]::Beep(1568, 300)
    Start-Sleep -Seconds 1
}

"20s"
Start-Sleep -Seconds 20



# ������λ�úͼ��ʱ�������
$clickPositions = @(
    @{ x = 30; y = 1050; interval = 2 },
    @{ x = 30; y = 980; interval = 2 }
)
 
# �����ܵ�����������Զ�������

$totalClicks = 1
 
for ($i = 0; $i -lt $totalClicks; $i++) {
    foreach ($pos in $clickPositions) {
        Write-Output "Clicking at ($($pos.x), $($pos.y)) - $($i + 1) / $totalClicks"
        Click-AtPosition -x $pos.x -y $pos.y
        Start-Sleep -Seconds $pos.interval
    }
}

[Console]::Beep(1568, 300)
[Console]::Beep(1318, 300)
[Console]::Beep(1046, 300)

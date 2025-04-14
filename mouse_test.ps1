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
 
function Click-AtPosition($x, $y) {
    # Move the mouse to the specified position
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)
    
    # Perform the click
    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
    Start-Sleep -Milliseconds 100
    [Mouse]::mouse_event([Mouse]::MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)
}
 
# 定义点击位置和间隔时间的数组
$clickPositions = @(
    @{ x = 1030; y = 1040; interval = 5 },
    @{ x = 960; y = 690; interval = 5 }
)
 
# 定义总点击次数可以自定义设置

Start-Sleep -Seconds 10
$totalClicks = 1
 
for ($i = 0; $i -lt $totalClicks; $i++) {
    foreach ($pos in $clickPositions) {
        Write-Output "Clicking at ($($pos.x), $($pos.y)) - $($i + 1) / $totalClicks"
        Click-AtPosition -x $pos.x -y $pos.y
        Start-Sleep -Seconds $pos.interval
    }
}
 
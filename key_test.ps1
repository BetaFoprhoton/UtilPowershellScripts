
function Type-String {
    param(
        [string]$stringToType
    )
    $stringToType | ForEach-Object {
        $shell.SendKeys($_)
    }
}

$shell = New-Object -ComObject wscript.shell

Start-Sleep -Seconds 10
Type-String "ly123456"

#include <Date.au3>

$slackToken = ''

$defaultStatusText = '' 
$defaultStatusEmoji = '' 

$scheduledStatusText = 'Vacation'
$scheduledStatusEmoji = ':palm_tree:'
$scheduleEnd = '2018/06/15 20:00:00' ; Format is 'YYYY/MM/DD[ HH:MM:SS]'

; Thanks to https://www.autoitscript.com/forum/topic/95850-url-encoding/
Func _URLEncode($urlText)
    $url = ""
    For $i = 1 To StringLen($urlText)
        $acode = Asc(StringMid($urlText, $i, 1))
        Select
            Case ($acode >= 48 And $acode <= 57) Or _
                    ($acode >= 65 And $acode <= 90) Or _
                    ($acode >= 97 And $acode <= 122)
                $url = $url & StringMid($urlText, $i, 1)
            Case $acode = 32
                $url = $url & "+"
            Case Else
                $url = $url & "%" & Hex($acode, 2)
        EndSelect
    Next
    Return $url
EndFunc


$statusText = $defaultStatusText
$statusEmoji = $defaultStatusEmoji

If _DateDiff('s', _NowCalc(), $scheduleEnd) > 0 Then
	; Scheduled status is still onging
	$statusText = $scheduledStatusText
	$statusEmoji = $scheduledStatusEmoji
EndIf

; https://api.slack.com/methods/users.profile.set
$slackUrl = 'https://slack.com/api/users.profile.set?token=' & $slackToken & '&profile=' & _URLEncode('{"status_text": "' & $statusText & '", "status_emoji": "' & $statusEmoji & '"}')

$httpClient = ObjCreate('winhttp.winhttprequest.5.1')
$httpClient.Open('GET', $slackUrl, False)
$httpClient.Send()

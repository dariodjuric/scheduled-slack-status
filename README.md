# Scheduled Slack Status

This is an AutoIt script to set Slack status based on date and time. You can run it on a schedule, or on some event, such as log in to your machine. Once executed, it will check whether `$scheduleEnd` is in the future. If so, it will set status based on `$scheduledStatusText` and `$scheduledStatusEmoji`.

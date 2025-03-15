update-reminder() {
    UPDATE_TIMESTAMP="$HOME/.last_update_time"
    REMINDER_DAYS=7

    if [ -f "$UPDATE_TIMESTAMP" ]; then
        last_update=$(cat "$UPDATE_TIMESTAMP")
        current_time=$(date +%s)
        elapsed_days=$(( (current_time - last_update) / 86400 ))

        if [ "$elapsed_days" -ge "$REMINDER_DAYS" ]; then
            notify-send "Update Reminder" \
                "It's been $elapsed_days days since your last update! Consider running 'update-all' to stay up to date." \
                --icon=dialog-information
        fi
    fi
}


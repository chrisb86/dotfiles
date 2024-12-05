-- If Spotify is running, toggle play/pause. Otherwise do nothing
if application "Spotify" is running then
	using terms from application "Spotify"
    tell application "Spotify" to playpause
  end using terms from
end if
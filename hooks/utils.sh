# detect_language_from_shebang <file_path>
# Returns the detected language (e.g., "bash", "python", "sh") or an empty string.
detect_language_from_shebang() {
	local file="$1"

	if [[ ! -f "$file" ]] || [[ ! -r "$file" ]]; then
		echo ""
		return
	fi

	local first_line
	first_line=$(head -n 1 "$file" 2>/dev/null)

	if [[ "$first_line" =~ ^#!\ *(/usr/bin/env\ )?bash ]]; then
		echo "bash"
	elif [[ "$first_line" =~ ^#!\ *(/usr/bin/env\ )?sh ]]; then
		echo "sh"
	elif [[ "$first_line" =~ ^#!\ *(/usr/bin/env\ )?python ]]; then
		echo "python"
	else
		echo ""
	fi
}

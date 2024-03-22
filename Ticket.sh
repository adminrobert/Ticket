#####
# Ticket Management
#####

# This is a function to help with ticket management, it stores a list of tickets to file to easily recall them
# It sets the variable $t for easy use in commit messages
Ticket_PS1="${PS1}"
[ -z "${TicketFile}" ] && TicketFile="${HOME}/.tickets"
[ -z "${TicketIFS}" ] && TicketIFS=' '
Ticket () {
  [ -f "${TicketFile}" ] || touch "${TicketFile}"
  local Args=("${@}")
  local Cmd="${Args[0]}"
  local Rest=("${Args[@]:1}")
  local Selected=()
  case "${Cmd}" in
    n|new|a|add)
      if [ -n "${Rest[*]}" ]
      then
        local ID=${Rest[0]##*/}
        grep -q "^${ID}" "${TicketFile}" \
          && echo "Ticket ${ID} already exists" \
          && return 1
        echo "${ID} | ${Rest[*]:1} | $(date "+%Y/%m/%d-%H:%M:%S")" >> "${TicketFile}"
        echo "Added: ${ID}"
      else
        Ticket h
      fi
    ;;

    s|set)
      local IFS=$'\n'
      local Tickets=($(<"${TicketFile}"))
      unset IFS
      echo "Select multiple tickets, CTRL-D to stop"
      select ticket in "${Tickets[@]}"; do
        echo ""
        echo "Setting: ${ticket}, ${ticket%% *}"
        Selected+=("${ticket%% *}")
      done
      local IFS="${TicketIFS}"
      t="${Selected[*]}"
      unset IFS
      PS1="t(${t}) ${Ticket_PS1}"
    ;;

    u|unset) unset t && PS1="${Ticket_PS1}" ;;

    e|edit) ${EDITOR:-vim} "${TicketFile}" ;;

    h|help)
      echo "Track tickets from command line:

    Ticket [n|new <ticket> <description>] [suelh]

        n|new|a|add <ticket> <description>
            adds a new ticket to the list (${TicketFile})
        s|set
            sets the variable \$t to the selected tickets (CTRL-D to stop selection)
        u|unset
            unsets the variable \$t and restores the original PS1
        e|edit
            opens the ticket file in the editor
        l|list
            lists the tickets (Default action)
        h|help
            shows this help message

    \$t can then be used in commit messages or anywhere else to reference the selected tickets

    TicketFile location can be changed by setting the variable TicketFile
    You can also change the delimiter by setting the variable TicketIFS

    Examples:
      $ Ticket n \"JIRA-1234\" \"This is a description\"
      $ git commit -m \"\$t: This is a commit message\"
      $ Ticket
      JIRA-1234 some description
      JIRA-456 another ticket

    "
    ;;

    *) cat "${TicketFile}" ;;
  esac
}

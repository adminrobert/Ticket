#!/usr/bin/env bash
rm .tickets
TicketFile=".tickets"
. Ticket.sh

Test_Header () {
  echo ""
  echo "###"
  echo "# ${*}"
  echo "###"
}

Test_Header "Test adding some tickets"
Ticket n JIRA-1234 Short id via n
Ticket n https://url.com/to/jira/JIRA-456 Url ticket
Ticket a JIRA-789 short id via a
Ticket a JIRA-789 duplicate id via a


# Test listing tickets
Test_Header "Test listing tickets"
Ticket

# Test setting a ticket
Test_Header "Test setting a ticket"
Ticket s <<< $'1\n2\n'
echo "Selected: '${t}'"
echo "PS1: '${PS1}'"

# Test unsetting a ticket
Test_Header "Test unsetting a ticket"
Ticket u
echo "Selected: '${t}'"
echo "PS1: '${PS1}'"

# Show Ticket File
Test_Header "Show Ticket File"
cat ${TicketFile}

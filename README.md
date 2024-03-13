# Ticket
A shell function to manage tickets for easy adding to commit messages with $t

## Installation
Clone the repository and add the following line to your .bashrc
```bash
source /${HOME}/Ticket/Ticket.sh
```

## Usage
See `Ticket h` for usage
```bash
$ Ticket h
Track tickets from command line:

    Ticket [n|new <ticket> <description>] [suelh]

        n|new <ticket> <description>
            adds a new ticket to the list (/home/rharris/.tickets)
        s|set
            sets the variable $t to the selected tickets (CTRL-D to stop selection)
        u|unset
            unsets the variable $t and restores the original PS1
        e|edit
            opens the ticket file in the editor
        l|list
            lists the tickets (Default action)
        h|help
            shows this help message

    $t can then be used in commit messages or anywhere else to reference the selected tickets

    TicketFile location can be changed by setting the variable TicketFile
    You can also change the delimiter by setting the variable TicketIFS

    Examples:
      Ticket n "JIRA-1234" "This is a description"
      git commit -m "$t: This is a commit message"
```

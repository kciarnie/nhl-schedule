SHELL=/bin/bash

%:      # thanks to chakrit
    @:    # thanks to William Pursell

#: Runs Swift Format
format:
	@Scripts/format.sh

# Helper functions
help:
	@printf "\n%-23s %s\n" "Target" "Description"
	@printf "%-23s %s\n\n" "------" "-----------"
	@grep -B1 -E "^[a-zA-Z0-9_-]+\:([^\=]|$$)" Makefile \
     | grep -v --  -- \
     | sed 'N;s/\n/###/' \
     | sed -n 's/^#: \(.*\)###\(.*\):.*/\2###\1/p' \
     | column -t -s '####'
	@printf "\n"
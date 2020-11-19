# Awk script to copy C: lines from secondary file to input file,
# inserting them in matching tune number before the M: line

BEGIN {
    # Set field separator
    FS = ":";
}

# Match X: line
/^X:/ {
    # Get the tune number
    tune = $2;

    # Read second file
    while ((getline line < FILE2) > 0)
    {
        # Find X: line
        if (line ~ /^X:/)
        {
            # Check tune number
            split(line, a);
            if (a[2] == tune)
            {
                # Read second file
                while ((getline line < FILE2) > 0)
                {
                    # Stop on C: line
                    if (line ~ /^C:/)
                    {
                        break;
                    }

                    # Or K: line
                    if (line ~ /^K:/)
                    {
                        break;
                    }
                }
                break;
            }
        }
    }
}

# Match M: line
/^M:/ {
    # Check for C:
    if (line ~ /^C:/)
    {
        print line;
    }
}

# Print current line
{
    print;
}

BEGIN {
}

/^%%EndComments/ {

# Read the input file to find how many pages.

    while ((getline line < FILENAME) > 0)
    {
	if (line ~ /^%%Page:/)
	{
	    split(line, a);
	    pages = a[3];
	}
    }

# Insert a pages DSC line.

    print "%%Pages: " pages;
}

/^%%Page:/ {
    page = $2;
}

/^%%EndPageSetup/ {

# Offset odd and even pages for binding

    if ((page % 2) == 1)
	print "8.0 0 translate";

    if ((page % 2) == 0)
	print "-8.0 0 translate";

    print;

# Insert a page header, and a page number, bottom centre.

    print "12 0 F0";
    print "174.4 0 M (Sussex Tune Book) cshow";
    print "174.4 -548 M (- " page " -) cshow";

    next;
}

/^0 0 M \(Page/ {
    $4 = $4 ") rshow";
    $5 = "30 0 M (" $5 ") rshow";
    $6 = "66 0 M (" $6;
    print;
    next;
}

/^0 0 M \(/ {
    $1 = 16;
    $4 = $4 ") lshow";
    $5 = "50 0 M (" $5 ") lshow";
    $6 = "66 0 M (" $6;
    print;
    next;
}

{
    print;
}

END {
}
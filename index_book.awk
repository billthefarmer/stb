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

# Get the page number

    page = $2;
}

/^%%EndPageSetup/ {

# Offset odd and even pages for binding

    if ((page % 4) == 1)
	print "34.02 0 translate";

    if ((page % 4) == 0)
	print "-34.02 0 translate";

    print;

# Insert a page header, and a page number

    if ((page % 4) == 2)
    {
	print "12 0 F0";
	print "324.7 0 moveto (Sussex Tune Book) lshow";
	print "348.7 0 moveto (" (page / 2) ") lshow";
    }

    if ((page % 4) == 3)
    {
	print "12 0 F0";
	print "24 0 moveto (Sussex Tune Book) rshow";
	print "0 0 moveto (" ((page + 1) / 2) ") rshow";
    }

    next;
}

/^0 0 M \(Page/ {
    $4 = $4 ") rshow ";
    $5 = "30 0 M (" $5 ") rshow ";
    $6 = "66 0 M (" $6;
    print;
    next;
}

/^0 0 M \(/ {
    $1 = 16;
    p = substr($4, 2);

    if ((p % 2) == 0)
	p = p / 2;
    else
	p = (p + 1) / 2;

    $4 = "(" p ") lshow";
    $5 = "50 0 M (" $5 ") lshow";
    $6 = "66 0 M (" $6;
    print;
    next;
}

{
    print;
}
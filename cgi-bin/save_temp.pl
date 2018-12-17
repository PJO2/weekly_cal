#!/usr/bin/perl

# write the calendar return by web client 
# to calendar.txt


local ($buffer, @pairs, $pair, $name, $value, %FORM);
# Read in text
$ENV{'REQUEST_METHOD'} =~ tr/a-z/A-Z/;

if ($ENV{'REQUEST_METHOD'} eq "POST") {
   read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'});
} else {
   $buffer = $ENV{'QUERY_STRING'};
}

# Split information into name/value pairs
@pairs = split(/&/, $buffer);

foreach $pair (@pairs) {
   ($name, $value) = split(/=/, $pair);
   $value =~ tr/+/ /;
   $value =~ s/%(..)/pack("C", hex($1))/eg;
   $FORM{$name} = $value;
}


print "Content-type:text/html\r\n\r\n";
print "<html>";
print "<head>";
print "<title>Temperatures enregistrees</title>";
print "</head>";
print "<body>";
print "<h2>Temperatures enregistr&eacute;es</h2>";
print "<p>Temp confort: " . $FORM{'TempConfort'};
print "<p>Temp eco: " . $FORM{'TempEco'};
print "</body>";
print "</html>";

1;

# Actions : mise a jour de domotciz
my $url = "http://localhost:8080/json.htm?type=command&param=updateuservariable&vname=Temp%20eco&vtype=1&vvalue=" . $FORM{'TempEco'};
`wget -q -O - '$url'`;
$url = "http://localhost:8080/json.htm?type=command&param=updateuservariable&vname=Temp%20confort&vtype=1&vvalue=" . $FORM{'TempConfort'};
`wget -q -O - '$url'`;





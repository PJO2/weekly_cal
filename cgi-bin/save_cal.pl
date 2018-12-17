#!/usr/bin/perl

# write the calendar return by web client 
# to calendar.txt

use strict;
use warnings;
use URI::Escape;

my $CAL = '/home/pi/public_html/calendar.txt';
my $headers = <<'EOF';
# entry => (Minutes Hour Day (w for weekdays, e weekends, * all) Status
# 0 is sunday, 1 monday, 2 tuesday
# since script is called every 5 minutes, minutes should be multiple of 5
EOF


sub WriteCalendar
{
   my $str = shift;
   open(my $fh, ">$CAL") or die;
   print $fh $headers;
   print $fh '# ' . $str;
   close ($fh);
}


   my $buffer = '';
   if($ENV{CONTENT_LENGTH}) { read(STDIN,$buffer,$ENV{CONTENT_LENGTH}); }
   print "Content-type: text/plain\n\n";
   print 'Data saved';
   
   if( ! length($buffer) ) { $buffer = '[No POST data received]'; }
   WriteCalendar (uri_unescape ($buffer) );


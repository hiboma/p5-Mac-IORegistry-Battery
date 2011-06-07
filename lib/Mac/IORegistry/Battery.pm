package Mac::IORegistry::Battery;

use strict;
use warnings;
use Carp;

our $IOREG         = q{/usr/sbin/ioreg};
our $COMMAND_IOREG = qq{$IOREG -r -n AppleSmartBattery};

sub get {
    my ($class) = @_;

    unless(-f $IOREG) {
        die "command '$IOREG' not found. Is your platform Mac OSX ?";
    }

    my $output = `$COMMAND_IOREG`;
    unless($output) {
        die "failed exec '$COMMAND_IOREG'";
    }
    $class->_parse($output);
}

sub _parse {
    my ($class, $line) = @_;

    my $registry = {};
    foreach (split /\n/, $line) {

        s/^\s+//;
        next if /AppleSmartBattery/;

        my ($key, $value) = split / = /;

        next unless $key;
        next if $key eq '{';
        next if $key eq '}';

        $key =~ s/"//g;
        if($value =~ /^{/) {
            $registry->{$key} = $class->_parse_hashlike_line($value);
        } elsif($value =~ /^\(/) {
            $registry->{$key} = $class->_parse_arraylike_line($value);
        } else {
            $value =~ s/"//g;
            $registry->{$key} = $value;
        }
    }

    $registry;
}

sub _parse_arraylike_line {
    my ($class, $line) = @_;

    $line =~ s/^\(//;
    $line =~ s/\)$//;
    [ split /,/, $line ];
}


sub _parse_hashlike_line {
    my ($class, $line) = @_;

    $line =~ s/^{//;
    $line =~ s/}$//;
    my $registry = {} ;
    my @sublines = split /,/, $line;
    foreach (@sublines){
        my ($_key, $_value) = split /=/;
        $_key =~ s/"//g;
        $registry->{$_key} = $_value;
    }
    $registry;
}


=head1 NAME

Mac::IORegistry::Battery - The great new Mac::IORegistry::Battery!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Mac::IORegistry::Battery;

    my $foo = Mac::IORegistry::Battery->new();
    ...

=head1 EXPORT

A list of functions that can be exported.  You can delete this section
if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 get

=head1 AUTHOR

hiboma, C<< <hiroyan at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-mac-ioreistry-battery at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Mac-IORegistry-Battery>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Mac::IORegistry::Battery


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Mac-IORegistry-Battery>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Mac-IORegistry-Battery>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Mac-IORegistry-Battery>

=item * Search CPAN

L<http://search.cpan.org/dist/Mac-IORegistry-Battery/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 hiboma.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Mac::IORegistry::Battery

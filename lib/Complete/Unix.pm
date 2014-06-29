package Complete::Unix;

use 5.010001;
use strict;
use warnings;
#use Log::Any '$log';

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       complete_uid
                       complete_user
                       complete_gid
                       complete_group

                       complete_pid
               );

our $DATE = '2014-06-29'; # DATE
our $VERSION = '0.01'; # VERSION

our %SPEC;

$SPEC{complete_uid} = {
    v => 1.1,
    summary => 'Complete from list of Unix UID\'s',
    args => {
        word    => { schema=>[str=>{default=>''}], pos=>0 },
        ci      => { schema=>[bool=>{default=>0}] },
        etc_dir => { schema=>['str*'] },
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_uid {
    require Complete::Util;
    require Unix::Passwd::File;

    my %args  = @_;
    my $word  = $args{word} // "";

    my $res = Unix::Passwd::File::list_users(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array(
        array=>[map {$_->{uid}} @{ $res->[2] }],
                word=>$args{word}, ci=>$args{ci});
}

$SPEC{complete_user} = {
    v => 1.1,
    summary => 'Complete from list of Unix users',
    args => {
        word    => { schema=>[str=>{default=>''}], pos=>0 },
        ci      => { schema=>[bool=>{default=>0}] },
        etc_dir => { schema=>['str*'] },
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_user {
    require Complete::Util;
    require Unix::Passwd::File;

    my %args  = @_;
    my $word  = $args{word} // "";

    my $res = Unix::Passwd::File::list_users(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array(
        array=>[map {$_->{user}} @{ $res->[2] }],
                word=>$args{word}, ci=>$args{ci});
}

$SPEC{complete_gid} = {
    v => 1.1,
    summary => 'Complete from list of Unix GID\'s',
    args => {
        word    => { schema=>[str=>{default=>''}], pos=>0 },
        ci      => { schema=>[bool=>{default=>0}] },
        etc_dir => { schema=>['str*'] },
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_gid {
    require Complete::Util;
    require Unix::Passwd::File;

    my %args  = @_;
    my $word  = $args{word} // "";

    my $res = Unix::Passwd::File::list_groups(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array(
        array=>[map {$_->{gid}} @{ $res->[2] }],
                word=>$args{word}, ci=>$args{ci});
}

$SPEC{complete_group} = {
    v => 1.1,
    summary => 'Complete from list of Unix groups',
    args => {
        word    => { schema=>[str=>{default=>''}], pos=>0 },
        ci      => { schema=>[bool=>{default=>0}] },
        etc_dir => { schema=>['str*'] },
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_group {
    require Complete::Util;
    require Unix::Passwd::File;

    my %args  = @_;
    my $word  = $args{word} // "";

    my $res = Unix::Passwd::File::list_groups(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array(
        array=>[map {$_->{group}} @{ $res->[2] }],
                word=>$args{word}, ci=>$args{ci});
}

$SPEC{complete_pid} = {
    v => 1.1,
    summary => 'Complete from list of running PIDs',
    args => {
        word    => { schema=>[str=>{default=>''}], pos=>0 },
        ci      => { schema=>[bool=>{default=>0}] },
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_pid {
    require Complete::Util;
    require Proc::ProcessTable;

    state $pt = Proc::ProcessTable->new;

    my %args  = @_;
    my $word  = $args{word} // "";

    my $procs = $pt->table;
    Complete::Util::complete_array(
        array=>[map {$_->{pid}} @$procs],
                word=>$args{word}, ci=>$args{ci});
}

1;
# ABSTRACT: Unix-related completion routines

__END__

=pod

=encoding UTF-8

=head1 NAME

Complete::Unix - Unix-related completion routines

=head1 VERSION

This document describes version 0.01 of Complete::Unix (from Perl distribution Complete-Unix), released on 2014-06-29.

=head1 DESCRIPTION

=head1 FUNCTIONS


=head2 complete_gid(%args) -> array

Complete from list of Unix GID's.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool> (default: 0)

=item * B<etc_dir> => I<str>

=item * B<word> => I<str> (default: "")

=back

Return value:


=head2 complete_group(%args) -> array

Complete from list of Unix groups.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool> (default: 0)

=item * B<etc_dir> => I<str>

=item * B<word> => I<str> (default: "")

=back

Return value:


=head2 complete_pid(%args) -> array

Complete from list of running PIDs.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool> (default: 0)

=item * B<word> => I<str> (default: "")

=back

Return value:


=head2 complete_uid(%args) -> array

Complete from list of Unix UID's.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool> (default: 0)

=item * B<etc_dir> => I<str>

=item * B<word> => I<str> (default: "")

=back

Return value:


=head2 complete_user(%args) -> array

Complete from list of Unix users.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool> (default: 0)

=item * B<etc_dir> => I<str>

=item * B<word> => I<str> (default: "")

=back

Return value:

=head1 SEE ALSO

L<Complete::Util>

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Complete-Unix>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Complete-Unix>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Complete-Unix>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

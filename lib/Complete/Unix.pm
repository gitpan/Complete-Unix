package Complete::Unix;

our $DATE = '2014-12-27'; # DATE
our $VERSION = '0.03'; # VERSION

use 5.010001;
use strict;
use warnings;
#use Log::Any '$log';

use Complete;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(
                       complete_uid
                       complete_user
                       complete_gid
                       complete_group

                       complete_pid
                       complete_proc_name
                );

our %SPEC;

our %common_args = (
    word    => { schema=>[str=>{default=>''}], pos=>0, req=>1 },
    ci      => { schema=>['bool'] },
);

$SPEC{':package'} = {
    v => 1.1,
    summary => 'Unix-related completion routines',
};

$SPEC{complete_uid} = {
    v => 1.1,
    summary => 'Complete from list of Unix UID\'s',
    args => {
        %common_args,
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
    my $ci    = $args{ci} // $Complete::OPT_CI;

    my $res = Unix::Passwd::File::list_users(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array_elem(
        array=>[map {$_->{uid}} @{ $res->[2] }],
                word=>$word, ci=>$ci);
}

$SPEC{complete_user} = {
    v => 1.1,
    summary => 'Complete from list of Unix users',
    args => {
        %common_args,
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
    my $ci    = $args{ci} // $Complete::OPT_CI;

    my $res = Unix::Passwd::File::list_users(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array_elem(
        array=>[map {$_->{user}} @{ $res->[2] }],
                word=>$word, ci=>$ci);
}

$SPEC{complete_gid} = {
    v => 1.1,
    summary => 'Complete from list of Unix GID\'s',
    args => {
        %common_args,
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
    my $ci    = $args{ci} // $Complete::OPT_CI;

    my $res = Unix::Passwd::File::list_groups(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array_elem(
        array=>[map {$_->{gid}} @{ $res->[2] }],
                word=>$word, ci=>$ci);
}

$SPEC{complete_group} = {
    v => 1.1,
    summary => 'Complete from list of Unix groups',
    args => {
        %common_args,
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
    my $ci    = $args{ci} // $Complete::OPT_CI;

    my $res = Unix::Passwd::File::list_groups(
        etc_dir=>$args{etc_dir}, detail=>1);
    return undef unless $res->[0] == 200;
    Complete::Util::complete_array_elem(
        array=>[map {$_->{group}} @{ $res->[2] }],
                word=>$word, ci=>$ci);
}

$SPEC{complete_pid} = {
    v => 1.1,
    summary => 'Complete from list of running PIDs',
    args => {
        %common_args,
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_pid {
    require Complete::Util;
    require Proc::Find;

    my %args  = @_;
    my $word  = $args{word} // "";
    my $ci    = $args{ci} // $Complete::OPT_CI;

    Complete::Util::complete_array_elem(
        array=>Proc::Find::find_proc(),
                word=>$word, ci=>$ci);
}

$SPEC{complete_proc_name} = {
    v => 1.1,
    summary => 'Complete from list of process names',
    args => {
        %common_args,
    },
    result_naked => 1,
    result => {
        schema => 'array',
    },
};
sub complete_proc_name {
    require Complete::Util;
    require List::MoreUtils;
    require Proc::Find;

    my %args  = @_;
    my $word  = $args{word} // "";
    my $ci    = $args{ci} // $Complete::OPT_CI;

    Complete::Util::complete_array_elem(
        array=>[List::MoreUtils::uniq(
            grep {length}
                map { $_->{name} }
                    @{ Proc::Find::find_proc(detail=>1) })],
        word=>$word, ci=>$ci);
}

1;
# ABSTRACT: Unix-related completion routines

__END__

=pod

=encoding UTF-8

=head1 NAME

Complete::Unix - Unix-related completion routines

=head1 VERSION

This document describes version 0.03 of Complete::Unix (from Perl distribution Complete-Unix), released on 2014-12-27.

=head1 DESCRIPTION

=head1 FUNCTIONS


=head2 complete_gid(%args) -> array

Complete from list of Unix GID's.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<etc_dir> => I<str>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)


=head2 complete_group(%args) -> array

Complete from list of Unix groups.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<etc_dir> => I<str>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)


=head2 complete_pid(%args) -> array

Complete from list of running PIDs.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)


=head2 complete_proc_name(%args) -> array

Complete from list of process names.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)


=head2 complete_uid(%args) -> array

Complete from list of Unix UID's.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<etc_dir> => I<str>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)


=head2 complete_user(%args) -> array

Complete from list of Unix users.

Arguments ('*' denotes required arguments):

=over 4

=item * B<ci> => I<bool>

=item * B<etc_dir> => I<str>

=item * B<word>* => I<str> (default: "")

=back

Return value:

 (array)

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

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

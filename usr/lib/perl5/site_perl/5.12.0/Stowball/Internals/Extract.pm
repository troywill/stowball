package Stowball::Internals::Extract;
use strict;
use File::Spec                  ();
use File::Basename              ();
use Archive::Extract;

Archive::Extract(3)              Perl Programmers Reference Guide             Archive::Extract(3)

NAME
       Archive::Extract - A generic archive extracting mechanism

SYNOPSIS
           use Archive::Extract;

           ### build an Archive::Extract object ###
           my $ae = Archive::Extract->new( archive => 'foo.tgz' );

           ### extract to cwd() ###
           my $ok = $ae->extract;

           ### extract to /tmp ###
           my $ok = $ae->extract( to => '/tmp' );

           ### what if something went wrong?
           my $ok = $ae->extract or die $ae->error;

           ### files from the archive ###
           my $files   = $ae->files;

           ### dir that was extracted to ###
           my $outdir  = $ae->extract_path;

           ### quick check methods ###
           $ae->is_tar     # is it a .tar file?
           $ae->is_tgz     # is it a .tar.gz or .tgz file?
           $ae->is_gz;     # is it a .gz file?
           $ae->is_zip;    # is it a .zip file?
           $ae->is_bz2;    # is it a .bz2 file?
           $ae->is_tbz;    # is it a .tar.bz2 or .tbz file?
           $ae->is_lzma;   # is it a .lzma file?

           ### absolute path to the archive you provided ###
           $ae->archive;

           ### commandline tools, if found ###
           $ae->bin_tar     # path to /bin/tar, if found
           $ae->bin_gzip    # path to /bin/gzip, if found
           $ae->bin_unzip   # path to /bin/unzip, if found
           $ae->bin_bunzip2 # path to /bin/bunzip2 if found
           $ae->bin_unlzma  # path to /bin/unlzma if found

DESCRIPTION
       Archive::Extract is a generic archive extraction mechanism.

       It allows you to extract any archive file of the type .tar, .tar.gz, .gz, .Z, tar.bz2,
       .tbz, .bz2, .zip or .lzma without having to worry how it does so, or use different
       interfaces for each type by using either perl modules, or commandline tools on your
       system.

       See the "HOW IT WORKS" section further down for details.

METHODS
   $ae = Archive::Extract->new(archive => '/path/to/archive',[type => TYPE])
       Creates a new "Archive::Extract" object based on the archive file you passed it.
       Automatically determines the type of archive based on the extension, but you can override
       that by explicitly providing the "type" argument.

       Valid values for "type" are:

       tar Standard tar files, as produced by, for example, "/bin/tar".  Corresponds to a ".tar"
           suffix.

       tgz Gzip compressed tar files, as produced by, for example "/bin/tar -z".  Corresponds to
           a ".tgz" or ".tar.gz" suffix.

       gz  Gzip compressed file, as produced by, for example "/bin/gzip".  Corresponds to a ".gz"
           suffix.

       Z   Lempel-Ziv compressed file, as produced by, for example "/bin/compress".  Corresponds
           to a ".Z" suffix.

       zip Zip compressed file, as produced by, for example "/bin/zip".  Corresponds to a ".zip",
           ".jar" or ".par" suffix.

       bz2 Bzip2 compressed file, as produced by, for example, "/bin/bzip2".  Corresponds to a
           ".bz2" suffix.

       tbz Bzip2 compressed tar file, as produced by, for exmample "/bin/tar -j".  Corresponds to
           a ".tbz" or ".tar.bz2" suffix.

       lzma
           Lzma compressed file, as produced by "/bin/lzma".  Corresponds to a ".lzma" suffix.

       Returns a "Archive::Extract" object on success, or false on failure.

   $ae->extract( [to => '/output/path'] )
       Extracts the archive represented by the "Archive::Extract" object to the path of your
       choice as specified by the "to" argument. Defaults to "cwd()".

       Since ".gz" files never hold a directory, but only a single file; if the "to" argument is
       an existing directory, the file is extracted there, with its ".gz" suffix stripped.  If
       the "to" argument is not an existing directory, the "to" argument is understood to be a
       filename, if the archive type is "gz".  In the case that you did not specify a "to"
       argument, the output file will be the name of the archive file, stripped from its ".gz"
       suffix, in the current working directory.

       "extract" will try a pure perl solution first, and then fall back to commandline tools if
       they are available. See the "GLOBAL VARIABLES" section below on how to alter this
       behaviour.

       It will return true on success, and false on failure.

       On success, it will also set the follow attributes in the object:

       $ae->extract_path
           This is the directory that the files where extracted to.

       $ae->files
           This is an array ref with the paths of all the files in the archive, relative to the
           "to" argument you specified.  To get the full path to an extracted file, you would
           use:

               File::Spec->catfile( $to, $ae->files->[0] );

           Note that all files from a tar archive will be in unix format, as per the tar
           specification.

ACCESSORS
   $ae->error([BOOL])
       Returns the last encountered error as string.  Pass it a true value to get the
       "Carp::longmess()" output instead.

   $ae->extract_path
       This is the directory the archive got extracted to.  See "extract()" for details.

   $ae->files
       This is an array ref holding all the paths from the archive.  See "extract()" for details.

   $ae->archive
       This is the full path to the archive file represented by this "Archive::Extract" object.

   $ae->type
       This is the type of archive represented by this "Archive::Extract" object. See accessors
       below for an easier way to use this.  See the "new()" method for details.

   $ae->types
       Returns a list of all known "types" for "Archive::Extract"'s "new" method.

   $ae->is_tgz
       Returns true if the file is of type ".tar.gz".  See the "new()" method for details.

   $ae->is_tar
       Returns true if the file is of type ".tar".  See the "new()" method for details.

   $ae->is_gz
       Returns true if the file is of type ".gz".  See the "new()" method for details.

   $ae->is_Z
       Returns true if the file is of type ".Z".  See the "new()" method for details.

   $ae->is_zip
       Returns true if the file is of type ".zip".  See the "new()" method for details.

   $ae->is_lzma
       Returns true if the file is of type ".lzma".  See the "new()" method for details.

   $ae->bin_tar
       Returns the full path to your tar binary, if found.

   $ae->bin_gzip
       Returns the full path to your gzip binary, if found

   $ae->bin_unzip
       Returns the full path to your unzip binary, if found

   $ae->bin_unlzma
       Returns the full path to your unlzma binary, if found

   $bool = $ae->have_old_bunzip2
       Older versions of "/bin/bunzip2", from before the "bunzip2 1.0" release, require all
       archive names to end in ".bz2" or it will not extract them. This method checks if you have
       a recent version of "bunzip2" that allows any extension, or an older one that doesn't.

HOW IT WORKS
       "Archive::Extract" tries first to determine what type of archive you are passing it, by
       inspecting its suffix. It does not do this by using Mime magic, or something related. See
       "CAVEATS" below.

       Once it has determined the file type, it knows which extraction methods it can use on the
       archive. It will try a perl solution first, then fall back to a commandline tool if that
       fails. If that also fails, it will return false, indicating it was unable to extract the
       archive.  See the section on "GLOBAL VARIABLES" to see how to alter this order.

CAVEATS
   File Extensions
       "Archive::Extract" trusts on the extension of the archive to determine what type it is,
       and what extractor methods therefore can be used. If your archives do not have any of the
       extensions as described in the "new()" method, you will have to specify the type
       explicitly, or "Archive::Extract" will not be able to extract the archive for you.

   Supporting Very Large Files
       "Archive::Extract" can use either pure perl modules or command line programs under the
       hood. Some of the pure perl modules (like "Archive::Tar" and Compress::unLZMA) take the
       entire contents of the archive into memory, which may not be feasible on your system.
       Consider setting the global variable $Archive::Extract::PREFER_BIN to 1, which will prefer
       the use of command line programs and won't consume so much memory.

       See the "GLOBAL VARIABLES" section below for details.

   Bunzip2 support of arbitrary extensions.
       Older versions of "/bin/bunzip2" do not support arbitrary file extensions and insist on a
       ".bz2" suffix. Although we do our best to guard against this, if you experience a bunzip2
       error, it may be related to this. For details, please see the "have_old_bunzip2" method.

GLOBAL VARIABLES
   $Archive::Extract::DEBUG
       Set this variable to "true" to have all calls to command line tools be printed out,
       including all their output.  This also enables "Carp::longmess" errors, instead of the
       regular "carp" errors.

       Good for tracking down why things don't work with your particular setup.

       Defaults to "false".

   $Archive::Extract::WARN
       This variable controls whether errors encountered internally by "Archive::Extract" should
       be "carp"'d or not.

       Set to false to silence warnings. Inspect the output of the "error()" method manually to
       see what went wrong.

       Defaults to "true".

   $Archive::Extract::PREFER_BIN
       This variables controls whether "Archive::Extract" should prefer the use of perl modules,
       or commandline tools to extract archives.

       Set to "true" to have "Archive::Extract" prefer commandline tools.

       Defaults to "false".

TODO / CAVEATS
       Mime magic support
           Maybe this module should use something like "File::Type" to determine the type, rather
           than blindly trust the suffix.

       Thread safety
           Currently, "Archive::Extract" does a "chdir" to the extraction dir before extraction,
           and a "chdir" back again after. This is not necessarily thread safe. See "rt.cpan.org"
           bug "#45671" for details.

BUG REPORTS
       Please report bugs or other issues to <bug-archive-extract@rt.cpan.org<gt>.

AUTHOR
       This module by Jos Boumans <kane@cpan.org>.

COPYRIGHT
       This library is free software; you may redistribute and/or modify it under the same terms
       as Perl itself.

perl v5.12.0                                2010-01-18                        Archive::Extract(3)



1;
__END__
package CPANPLUS::Internals::Extract;



use CPANPLUS::Error;
use CPANPLUS::Internals::Constants;

use File::Spec                  ();
use File::Basename              ();
use Archive::Extract;
use IPC::Cmd                    qw[run];
use Params::Check               qw[check];
use Module::Load::Conditional   qw[can_load check_install];
use Locale::Maketext::Simple    Class => 'CPANPLUS', Style => 'gettext';

local $Params::Check::VERBOSE = 1;

=pod

=head1 NAME

CPANPLUS::Internals::Extract

=head1 SYNOPSIS

    ### for source files ###
    $self->_gunzip( file => 'foo.gz', output => 'blah.txt' );
    
    ### for modules/packages ###
    $dir = $self->_extract( module      => $modobj, 
                            extractdir  => '/some/where' );

=head1 DESCRIPTION

CPANPLUS::Internals::Extract extracts compressed files for CPANPLUS.
It can do this by either a pure perl solution (preferred) with the 
use of C<Archive::Tar> and C<Compress::Zlib>, or with binaries, like
C<gzip> and C<tar>.
 
The flow looks like this:

    $cb->_extract
        Delegate to Archive::Extract
 
=head1 METHODS

=head2 $dir = _extract( module => $modobj, [perl => '/path/to/perl', extractdir => '/path/to/extract/to', prefer_bin => BOOL, verbose => BOOL, force => BOOL] )

C<_extract> will take a module object and extract it to C<extractdir>
if provided, or the default location which is obtained from your 
config.

The file name is obtained by looking at C<< $modobj->status->fetch >>
and will be parsed to see if it's a tar or zip archive.

If it's a zip archive, C<__unzip> will be called, otherwise C<__untar>
will be called. In the unlikely event the file is of neither format,
an error will be thrown.

C<_extract> takes the following options:

=over 4

=item module

A C<CPANPLUS::Module> object. This is required.

=item extractdir

The directory to extract the archive to. By default this looks 
something like:
    /CPANPLUS_BASE/PERL_VERSION/BUILD/MODULE_NAME

=item prefer_bin

A flag indicating whether you prefer a pure perl solution, ie
C<Archive::Tar> or C<Archive::Zip> respectively, or a binary solution
like C<unzip> and C<tar>.

=item perl

The path to the perl executable to use for any perl calls. Also used
to determine the build version directory for extraction.

=item verbose

Specifies whether to be verbose or not. Defaults to your corresponding
config entry.

=item force

Specifies whether to force the extraction or not. Defaults to your
corresponding config entry.

=back

All other options are passed on verbatim to C<__unzip> or C<__untar>.

Returns the directory the file was extracted to on success and false
on failure.

=cut

sub _extract {
    my $self = shift;
    my $conf = $self->configure_object;
    my %hash = @_;
    
    local $Params::Check::ALLOW_UNKNOWN = 1;
    
    my( $mod, $verbose, $force );
    my $tmpl = {
        force       => { default => $conf->get_conf('force'),   
                            store => \$force },
        verbose     => { default => $conf->get_conf('verbose'), 
                            store => \$verbose },
        prefer_bin  => { default => $conf->get_conf('prefer_bin') },
        extractdir  => { default => $conf->get_conf('extractdir') },
        module      => { required => 1, allow => IS_MODOBJ, store => \$mod },
        perl        => { default => $^X },
    };
    
    my $args = check( $tmpl, \%hash ) or return;
    
    ### did we already extract it ? ###
    my $loc = $mod->status->extract();
    
    if( $loc && !$force ) {
        msg(loc("Already extracted '%1' to '%2'. ".
                "Won't extract again without force",
                $mod->module, $loc), $verbose);
        return $loc;
    }

    ### did we already fetch the file? ###
    my $file = $mod->status->fetch();
    unless( -s $file ) {
        error( loc( "File '%1' has zero size: cannot extract", $file ) );    
        return;
    }

    ### the dir to extract to ###
    my $to =    $args->{'extractdir'} ||
                File::Spec->catdir(
                        $conf->get_conf('base'),
                        $self->_perl_version( perl => $args->{'perl'} ),
                        $conf->_get_build('moddir'),
                );
 
    ### delegate to Archive::Extract ###
    ### set up some flags for archive::extract ###
    local $Archive::Extract::PREFER_BIN = $args->{'prefer_bin'};
    local $Archive::Extract::DEBUG      = $conf->get_conf('debug');
    local $Archive::Extract::WARN       = $verbose;

    my $ae = Archive::Extract->new( archive => $file );

    unless( $ae->extract( to => $to ) ) {
        error( loc( "Unable to extract '%1' to '%2': %3",
                    $file, $to, $ae->error ) );
        return;
    }
    
    ### if ->files is not filled, we dont know what the hell was
    ### extracted.. try to offer a suggestion and bail :(
    unless ( $ae->files ) {
        error( loc( "'%1' was not able to determine extracted ".
                    "files from the archive. Instal '%2' and ensure ".
                    "it works properly and try again",
                    $ae->is_zip ? 'Archive::Zip' : 'Archive::Tar' ) );
        return;                    
    }                    
    
    
    ### print out what files we extracted ###  
    msg(loc("Extracted '%1'",$_),$verbose) for @{$ae->files};  
    
    ### set them all to be +w for the owner, so we don't get permission
    ### denied for overwriting files that are just +r
    
    ### this is to rigurous -- just change to +w for the owner [cpan #13358] 
    #chmod 0755, map { File::Spec->rel2abs( File::Spec->catdir($to, $_) ) }
    #            @{$ae->files};
    
    for my $file ( @{$ae->files} ) { 
        my $path = File::Spec->rel2abs( File::Spec->catfile($to, $file) );
    
        $self->_mode_plus_w( file => $path );
    }
    
    ### check the return value for the extracted path ###
    ### Make an educated guess if we didn't get an extract_path
    ### back
    ### XXX apparently some people make their own dists and they 
    ### pack up '.' which means the leading directory is '.' 
    ### and only the second directory is the actual module directory
    ### so, we'll have to check if our educated guess exists first, 
    ### then see if the extract path works.. and if nothing works...
    ### well, then we really don't know.

    my $dir;
    for my $try (
        File::Spec->rel2abs( 
            ### _safe_path must be called before catdir because catdir on 
            ### VMS currently will not handle the extra dots in the directories.
            File::Spec->catdir( $self->_safe_path( path => $to ) ,  
                                $self->_safe_path( path =>
                                             $mod->package_name .'-'. 
                                             $mod->package_version
        ) ) ) ,
        File::Spec->rel2abs( $ae->extract_path ),
    ) {
        ($dir = $try) && last if -d $try;
    }
                                            
    ### test if the dir exists ###
    unless( $dir && -d $dir ) {
        error(loc("Unable to determine extract dir for '%1'",$mod->module));
        return;
    
    } else {    
        msg(loc("Extracted '%1' to '%2'", $mod->module, $dir), $verbose);
        
        ### register where we extracted the files to,
        ### also store what files were extracted
        $mod->status->extract( $dir ); 
        $mod->status->files( $ae->files );
    }
      
    ### also, figure out what kind of install we're dealing with ###
    $mod->get_installer_type();

    return $mod->status->extract();
}

1;

# Local variables:
# c-indentation-style: bsd
# c-basic-offset: 4
# indent-tabs-mode: nil
# End:
# vim: expandtab shiftwidth=4:

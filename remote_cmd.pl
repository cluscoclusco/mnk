#!/usr/bin/perl

# Author - Aik Zu Shyong
# Version - 0.0

use Term::ReadKey;	

$file		= $ARGV[0];
$script		= $ARGV[1];
$plink		= '/usr/bin/plink';

sub openFile
{
	if ( open SERVERLIST, $file )
	{
		@data = <SERVERLIST>;
		close(SERVERLIST);
	} 
	else 
	{
		die "Error! Invalid filename [$file], $!";
	}
	
	return @data;
}


sub runScript
{

	# print "Filename: $file\n";
	@server_list = &openFile;
	
	print "Username: ";
	$username = <STDIN>;
	chomp ( $username );

	print "Password: ";
	ReadMode('noecho');	
	$password = ReadLine(0);
	chomp ( $password );
	ReadMode('normal');	
	print "\n";

	#print "Your username: $username, password: $password, script: $script_name\n";
	
	foreach $server( @server_list )
	{
		chomp ( $server );
		next if $server =~ /^#/;
		print "Running on server: $server\n";
		#$command_set= "echo y | $plink -t -pw $password -m $script $username\@$server";
		$command_set="time $plink -t -pw $password -m $script $username\@$server | tee -a $script.log";
		#print "$command_set\n";
		
		# Debugging command set
		# print "[ $server ] --> $command_set\n";
		
		system "$command_set";
	}	
}


sub main
{

	if ( $file && $script) 
	{
		&runScript;
	} 
	else
	{
		die "Usage: remote_cmd.pl [SERVER_LIST_FILENAME] [SCRIPTNAME]\n";
	}
}

&main;

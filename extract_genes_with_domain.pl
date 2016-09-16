#! /usr/bin/perl

# Written by Tom de Man
#
# Produce a GFF3 file that only contains domain-containing protein genes. Domains are identified using hmmscan from hmmer 
# Protein genes without any motif or domain are less likely to be real

use strict;

if (scalar(@ARGV)==0){
	print "Usage: perl $0 <hmm file from hmmscan> <prokka gff3 file> \n";
	exit;
}

my $file = shift;
my $gff = shift;

my %domain_genes;
my $boolean = 0;

#open HMM file from hmmscan 
open FILE, "$file";

while (<FILE>) {
	chomp;
	my @split = split(' ', $_);
	if ($split[6] <= 1e-5) {
		$domain_genes{$split[3]} = 1;
	}
}
close FILE;

#open gff file 
open FILE, "$gff";
#create the new gff file
open OUT, ">$gff.hq.gff";

while (<FILE>) {
        chomp;
	if ($_ =~ m/##gff-version/i) {
		print OUT "$_\n";
	}
	if ($_ =~ m/##sequence-region/i) {
		print OUT "$_\n";
                $boolean = 1;
		next;
        }
	if ($_ =~ m/##fasta/i) {
		print OUT "$_\n";
		$boolean = 2;
		next;
	}
	if ($boolean == 1) {
        	my @split = split('=', $_);
		my @id = split(';', $split[1]);
		if (exists($domain_genes{$id[0]})) {
			print OUT "$_\n";
		}
	}
	if ($boolean == 2) {
		print OUT "$_\n";
	}
}
close FILE;
close OUT;

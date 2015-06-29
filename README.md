#NaS
NaS is a hybrid approach developed to take advantage of data generated using MinION device. We combine Illumina and Oxford Nanopore technologies to produce NaS (Nanopore Synthetic-long) reads of up to 60 kb that aligned with no error to the reference genome and spanned repetitive regions. 

NaS uses the MinION® read as a template 
to recruit Illumina reads and, by performing a local assembly, 
build a high-quality synthetic read. 
In the first step, a stringent alignment using BLAT (fast mode) or LAST (sensitive mode) is performed
to retrieve Illumina short reads and their complementary sequences,
called seed-reads. 
Next, the seed-read set is extended by searching for similar
reads and their complementary sequences in the initial set 
using Compareads (two reads are considered similar if they share 
several common k-mers). This second step is crucial to retrieve
Illumina reads that correspond to low-quality regions of the
template. 
Finally, a microassembly of the reads is performed, instead of 
a classical polishing of the consensus, using an overlap-layout-consensus
strategy, and repeats are resolved by a graph traversal algorithm.

NaS is distributed open-source under CeCILL 
FREE SOFTWARE LICENSE. Check out http://www.cecill.info/
for more information about the contents of this license.

NaS home on the web is http://www.genoscope.cns.fr/nas

Contact : nas [a] genoscope [.] cns [.] fr

PRE-REQUISITES
--------------

  - A Linux based operating system.
  - Binaries are provided for the following platform : Linux x86_64 (but some version like Ubuntu may not be compatible, see Troubleshooting)
  - Shell tool GNU Parallel ( http://www.gnu.org/software/parallel/ ) at least (22052015)
  - Perl 5.8.0 or higher installed.
  - Perl graph library (http://search.cpan.org/~jhi/Graph-0.94/)
  - Perl GetOpt module (http://search.cpan.org/dist/Getopt-Long/)
  - Perl Set::IntSpan module (http://search.cpan.org/~swmcd/Set-IntSpan-1.19/IntSpan.pm)
  - Newbler assembler v2.9 (available from 454 website)
  - Blat binary (at least v35) accessible through your PATH environnment variable
  - Last binary (at least 502) accessible through your PATH environnment variable

DEPENDENCIES
------------
The two following binaries : fastalength and fastacomposition
come from the exonerate software availaible under the LGPL
license. See http://www.ebi.ac.uk/~guy/exonerate/ for details.
The two following binaries : compareads2 and extrac_reads come
from the Compareads software available under the GPL license.
See http://alcovna.genouest.org/compareads/ for details.


INSTALLATION
------------

  1. Clone this GitHub repository
  2. Modify path to newbler and blat binaries (in NaS script, your PATH variable)
  3. Modify if needed the Perl and sh interpreters that have been set to : /usr/bin/perl and /bin/sh
  4. To test the program download this example dataset       
  `wget http://www.genoscope.cns.fr/externe/nas/datasets/NaS_example_acineto.tar.gz`
  5. Untar/unzip the archive :        
  `tar -zxvf NaS_example_acineto.tar.gz`
  6. Run NaS : 
```
$(pwd)/NaS_v2/NaS --fq1 NaS_example_acineto/AWK_DOSF_1_1_A5KR6.IND3_clean.10prc.fastq --fq2 NaS_example_acineto/AWK_DOSF_1_2_A5KR6.IND3_clean.10prc.fastq --nano NaS_example_acineto/MinION_reads_Acinetobacter_baylyi.fa --out NaS_example --nb_proc 5
```

RUNNING NaS
--------------
This part describes the different steps required to run NaS

The directory "NaS_example_acineto" provides an example of a NaS run performed on 5 MinION reads from Acinetobacter baylyi ADP1.

### Input
- MinION reads : NaS_example_acineto/MinION_reads_Acinetobacter_baylyi.fa

Sequence name line should not contain slash
- Illumina reads : NaS_example_acineto/AWK_DOSF_1_?_A5KR6.IND3_clean.10prc.fastq

Warning : At the moment, we only supported the following fastq format :
 - The sequence name line have to be a one field line
 - Sequence names have to end with '/1' (read1) and '/2' (read2)
Example :
@M2:A5KR6:1:1101:9590:1008/1
ACTCAAAGAACAAGAGTTACAGTCTAAAAAAGCTGCGGTTGC...
+
8ACCGGGGGGGGGGGGGGGGGGFGGGGGGGGGGGGGGGGGGG...

#################################################

#################################################

### Options

	--fq1        : illumina reads (R1) in fastQ format
	
	--fq2        : illumina reads (R2) in fastQ format
	
	--nano       : nanopore long reads in fastA format
	
	--out        : Output directory, default is NaS_date_pid
	
	--mode    : mode : fast or sensitive. fast mode use blat as aligner whereas sensitive mode use last, default is fast
	
	--tile       : ONLY in fast mode : tile size parameter of blat, default is 10
	
	--step       : ONLY in fast mode : step size parameter of blat, default is 5
	
	--a	       : ONLY in sensitive mode : gap existence cost parameter of last, default is 1
	
	--b	       : ONLY in sensitive mode : gap extension cost parameter of last, default is 1
	
	--e	       : ONLY in sensitive mode : score threshold parameter of last, default is 40
	
	--nb_proc    : Number of parallel task, default is 1
	
	-h           : help message
	
### Command to launch

```
$(pwd)/NaS_v2/NaS --fq1 NaS_example_acineto/AWK_DOSF_1_1_A5KR6.IND3_clean.10prc.fastq --fq2 NaS_example_acineto/AWK_DOSF_1_2_A5KR6.IND3_clean.10prc.fastq --nano NaS_example_acineto/MinION_reads_Acinetobacter_baylyi.fa --out NaS_example --nb_proc 5
```

### Result
`[lun. mars 30 10:41:40 CEST 2015] Create output directory : /env/cns/home/ggautrea/NaS_example`

`[lun. mars 30 10:41:40 CEST 2015] Create fasta file from fastq...`

`[lun. mars 30 10:42:47 CEST 2015] Alignement step...`

`[lun. mars 30 10:43:06 CEST 2015] Select reads...`

`[lun. mars 30 10:43:06 CEST 2015] Retrieve similar reads...`

`[lun. mars 30 10:45:22 CEST 2015] Generate NaS reads...`

`[lun. mars 30 10:45:37 CEST 2015] Generate statistics...`

`NbReads=  5  CumulativeSize=  31008  N50size=  7994  minSize=  2512  maxSize=  10464  avgSize=  6201.6  =>  /env/cns/home/ggautrea/NaS_example/NANO_reads.stats`

`NbReads=  5  CumulativeSize=  38036  N50size=  9743  minSize=  1982  maxSize=  12787  avgSize=  7607.2  =>  /env/cns/home/ggautrea/NaS_example/NaS_hqctg_reads.stats`

### Troubleshooting
#### Exonerate Binaries
```
fastalength: error while loading shared libraries: libglib-1.2.so.0: cannot open shared object file: No such file or directory
fastacomposition: error while loading shared libraries: libglib-1.2.so.0: cannot open shared object file: No such file or directory
```
This error message appears when exonerate binaries (fastalength and fastacompisition) provided with NaS are not compatible with your OS. To fix this issue, download sources from exonerate website: http://www.ebi.ac.uk/~guy/exonerate/ and compile them. Replace files : fastalength and fastacompisition in NaS_v2 directory.
#### Parallel too old
```
Unknown option: cat
Unknown option: cat
```
This error message appears when your version of parallel is too old. Update parallel to at least parallel22052015

ACKNOWLEDGMENTS
---------------

This work was financially supported by the Genoscope, 
Institut de Genomique, CEA and Agence Nationale de la 
Recherche (ANR), and France Génomique (ANR-10-INBS-09-08).

### NaS's developers
Jean-Marc Aury, Amin Madoui, Stefan Engelen and Guillaume Gautreau 

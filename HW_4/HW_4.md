# BMMB ASSIGNMENT 4
```bash
cd HW_4
conda activate bioinfo
bio
```

### Quick check on term exon
```bash
bio explain exon
```
### Output
exon (SO:0000147)

A region of the transcript sequence within a gene which is
not removed from the primary RNA transcript by RNA splicing.

Parents:
- transcript_region 

Children:
- coding_exon 
- noncoding_exon 
- interior_exon 
- decayed_exon (non_functional_homolog_of)
- pseudogenic_exon (non_functional_homolog_of)
- exon_region (part_of)
- exon_of_single_exon_gene 

# Get term heirarchy
```bash
bio explain exon --lineage
```
# Explaination
All the chidren nodes had the exon term in them.
The lineage function gave a hierarchical structure which provides insight into the functional and evolutionary classifications of exons.

### Gene ontology for organism Saccharomyces cerevisiae S288C

Genescape did not work for me so I used  Amigo to look for CC,MF and BF terms for SC S288C.

## CC - virion component
### virion component (GO:0044423)

Any constituent part of a virion, a complete fully
infectious extracellular virus particle.

Parents:
- cellular_component 

Children:
- viral nucleocapsid 
- viral capsid 
- viral tegument 
- viral membrane 
- viral outer capsid 
- viral inner capsid 
- viral intermediate capsid 
- virion nucleoid 
- structural constituent of virion (occurs_in)
- capsomere 
- viral procapsid 
- virion membrane 
- virus tail 
- viral capsid, decoration 
- virus tail, tip 
- virus tail, fiber 
- virus tail, baseplate 
- virus tail, tube 
- virus tail, sheath 
- virus tail, shaft 
- icosahedral viral capsid, spike 
- icosahedral viral capsid, neck 
- icosahedral viral capsid, collar 
- viral capsid, internal space

## MF - binding
### binding (GO:0005488)

The selective, non-covalent, often stoichiometric,
interaction of a molecule with one or more specific sites on
another molecule.

Parents:
- molecular_function 

Children:
- acyl binding 
- chromatin binding 
- antigen binding 
- protein binding 
- odorant binding 
- lipid binding 
- selenium binding 
- toxic substance binding 
- polyamine binding 
- carbohydrate binding 
- pigment binding 
- amide binding 
- 2-aminoethylphosphonate binding 
- dinitrosyl-iron complex binding 
- small molecule binding 
- neurotransmitter binding 
- hormone binding 
- ion binding 
- amine binding 
- poly(3-hydroxyalkanoate) binding 
- kinetochore binding 
- iron-sulfur-molybdenum cofactor binding 
- protein-containing complex binding 
- virion binding 
- host cell surface binding 
- hydroxyapatite binding 
- calcium oxalate binding 
- quinone binding 
- microfibril binding 
- ice binding 
- extracellular matrix binding 
- quaternary ammonium group binding 
- positive regulation of binding (positively_regulates)
- negative regulation of binding (negatively_regulates)
- prosthetic group binding 
- metal cluster binding 
- molecular adaptor activity (has_part)
- carbon monoxide binding 
- nitric oxide binding 
- alkene binding 
- modified amino acid binding 
- organic cyclic compound binding 
- flavonoid binding 
- carbohydrate derivative binding 
- molecular carrier activity (has_part)
- exogenous protein binding 
- molecular sequestering activity (has_part)
- cargo receptor ligand activity 
- heterocyclic compound binding 
- fatty acid derivative binding 
- sulfur compound binding 
- carbon dioxide binding 
- synthetic cannabinoid binding 
- tetrahydrofolyl-poly(glutamate) polymer binding 
- mgatp(2-) binding 
- cellulosome binding

## BF - growth
### growth (GO:0040007)

The increase in size or mass of an entire organism, a part
of an organism or a cell.

Parents:
- biological_process 

Children:
- primary ovarian follicle growth 
- preantral ovarian follicle growth 
- ovarian cumulus expansion 
- budding cell bud growth 
- cell growth 
- filamentous growth 
- uterine wall growth 
- negative regulation of growth (negatively_regulates)
- positive regulation of growth (positively_regulates)
- developmental growth 
- primary growth 
- lateral growth 
 
## Gene products for the term binding
NPR3, REI1, SOK2, CAP2, URM1, CDC39, FIG2, DSE2, UBA4, KIC1


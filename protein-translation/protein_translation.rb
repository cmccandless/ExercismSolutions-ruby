InvalidCodonError = Exception
class Translation
  @codons = {
    /^AUG$/ => 'Methionine',
    /^UGG$/ => 'Tryptophan',
    /^UU[CU]$/ => 'Phenylalanine',
    /^UU[AG]$/ => 'Leucine',
    /^UA[CU]$/ => 'Tyrosine',
    /^UG[CU]$/ => 'Cysteine',
    /^UC[ACGU]$/ => 'Serine',
    /^U(A[AG]|GA)$/ => 'STOP'
  }
  def self.of_codon(codon)
    @codons.each do |pattern, name|
      return name if codon =~ pattern
    end
    raise InvalidCodonError
  end

  def self.of_rna(rna)
    rna.chars
       .each_slice(3)
       .map(&:join)
       .map(&method(:of_codon))
       .take_while { |codon| codon != 'STOP' }
  end
end

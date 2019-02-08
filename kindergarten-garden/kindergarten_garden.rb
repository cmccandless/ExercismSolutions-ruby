class Garden
  def initialize(plants, students = %w[Alice Bob Charlie David
                                       Eve Fred Ginny Harriet
                                       Ileana Joseph Kincaid Larry])
    @plants = plants
    @students = students.sort
    create_methods
  end

  def chunk_plants
    @plants.split("\n")
           .collect { |ln| ln.chars.each_slice(2).to_a }
           .transpose
  end

  def parse_plant(plant)
    case plant
    when 'C'
      :clover
    when 'G'
      :grass
    when 'R'
      :radishes
    when 'V'
      :violets
    end
  end

  def create_methods
    chunk_plants.zip(@students).each do |slice, student|
      define_singleton_method :"#{student.downcase}" do
        slice.flatten.collect(&method(:parse_plant))
      end
    end
  end
end

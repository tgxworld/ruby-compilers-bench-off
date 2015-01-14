require 'byebug'
require 'csv'

results_file = Dir.glob('*.csv').last
exit if results_file.nil?

CSV.open('compilers_percentage_results.csv', 'w', write_headers: true) do |csv|
  lines = File.open(results_file).readlines
  lines.each_with_index do |line, index|
    if index == 0
      csv << line.chomp.split(',')
      next
    end

    results = line.split(',')
    type = results[0]
    results = results.drop(1).map(&:to_f)
    average = (results.reduce(:+) / results.length)

    results.map! do |result|
      result = (((result / average) * 100) - 100).round(2)
    end

    csv << results.unshift(type)
  end
end

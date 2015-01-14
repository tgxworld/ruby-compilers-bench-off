require 'csv'

CSV.open('compilers_results.csv', 'w', write_headers: true) do |csv|
  headers = [" "]
  datas = []

  Dir["*.txt"].sort.each_with_index do |file, index|
    file.match(/(.+).txt\Z/)
    headers << $1
    results = eval(File.open(file, 'r').read.gsub("NaN", "\"\""))

    %w{categories categories_admin home home_admin topic topic_admin}.each_with_index do |benchmark_type, line_number|
      datas[line_number] ||= []
      datas[line_number] << benchmark_type if index == 0
      data = results[benchmark_type][50]
      datas[line_number] << data
    end
  end

  csv << headers

  datas.each do |data|
    csv << data
  end
end

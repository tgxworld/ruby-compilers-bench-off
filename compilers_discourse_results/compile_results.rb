require 'csv'

CSV.open('compilers_results.csv', 'w', write_headers: true) do |csv|
  headers = [" "]
  datas = {}

  Dir["*.txt"].sort.each_with_index do |file, index|
    file.match(/(.+).txt\Z/)
    headers << $1
    results = eval(File.open(file, 'r').read.gsub("NaN", "\"\""))

    [50, 75, 90, 99].each do |percentile|
      %w{categories categories_admin home home_admin topic topic_admin}.each_with_index do |benchmark_type, line_number|
        datas[percentile] ||= []
        datas[percentile][line_number] ||= []
        datas[percentile][line_number] << "#{benchmark_type} - #{percentile} percentile" if index == 0
        data = results[benchmark_type][percentile]
        datas[percentile][line_number] << data
      end
    end
  end

  csv << headers

  datas.each do |_, value|
    value.each do |data|
      csv << data
    end
  end
end

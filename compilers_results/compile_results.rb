require 'csv'

CSV.open('compilers_results.csv', 'w', write_headers: true) do |csv|
  headers = [" "]
  datas = []

  Dir["*.txt"].sort.each_with_index do |file, index|
    file.match(/bm_(.+).txt\Z/)
    headers << $1
    content = File.open(file, 'r').readlines
    content_length = content.length

    content[5..(content_length - 3)].each_with_index do |line, line_number|
      benchmark_type, data = line.chomp.split("\t")
      datas[line_number] ||= []
      datas[line_number] << benchmark_type if index == 0
      datas[line_number] << data
    end
  end

  csv << headers

  datas.each do |data|
    csv << data
  end
end

# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

class Top4top
  # @return [TrueClass, FalseClass]
  def selectFile?(file)
    if File.file?(file) && File.exist?(file)
      @upload = file
      @selected = true
      true
    else
      @selected = false
      false
    end
  end

  def Upload
    if @selected
      uri = URI('https://top4top.io/index.php')
      request = Net::HTTP::Post.new(uri)
      form_data = [
        ['file_10_', ","],
        ['file_2_', File.open(@upload)],
        ['file_3_', ","],
        ['file_4_', ","],
        ['file_5_', ","],
        ['file_6_', ","],
        ['file_7_', ","],
        ['file_8_', ","],
        ['file_9_', ","],
        ['submitr', "[ رفع الملفات ]"],
      ]
      request.set_form form_data, 'multipart/form-data'
      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end
      html = Nokogiri.HTML(response.body.to_s)
      error_msg = html.search("ul.index_err")[0]
      unless error_msg.nil?
        error_msg = error_msg.content.sub!("  ", " ")
        error_msg = error_msg.sub!("تسجيل عضوية", "")
        error_msg = error_msg.sub!("\r", "")
        error_msg = error_msg.sub!("\n", "")
        error_msg = error_msg.sub!("\r\n", "")
        error_msg = error_msg.sub!("\r\n\r\n", "")
        {
          :status => false,
          :message => error_msg,
          :results => nil
        }
      else
        success_msg = "تم تحميل الصورة بنجاح"
        titles = []
        links = []
        html.search("ul.index_info p,btitle").each do |title|
          titles.append(title.content)
        end
        html.search("ul.index_info input.all_boxes").each do |link|
          links.append(link['value'])
        end
        loop = 0
        arr = []
        while loop < links.count
          arr[loop] = [
            titles[loop],
            links[loop]
          ]
          loop -= -1
        end
        @selected = false
        {
          :status => true,
          :message => success_msg,
          :results => arr
        }
      end
    else
      {
        :status => false,
        :message => "No file selected!",
        :results => nil
      }
    end
  end
end

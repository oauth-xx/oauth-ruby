module OAuth
  # source: https://gist.github.com/97756
  module Multipart
    CRLF = "\r\n"

    # Encodes the request as multipart
    def add_multipart_data(req,params)
      boundary = Time.now.to_i.to_s(16)
      req["Content-Type"] = "multipart/form-data; boundary=#{boundary}"
      body = ""
      params.each do |key,value|
        esc_key = CGI.escape(key.to_s)
        body << "--#{boundary}#{CRLF}"
        if value.respond_to?(:read)
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"; filename=\"#{File.basename(value.path)}\"#{CRLF}"
          body << "Content-Type: #{MIME::Types.type_for(value.path)}#{CRLF*2}"
          body << value.read
        else
          body << "Content-Disposition: form-data; name=\"#{esc_key}\"#{CRLF*2}#{value}"
        end
        body << CRLF
      end
      body << "--#{boundary}--#{CRLF*2}"
      req.body = body
      req["Content-Length"] = req.body.size
    end
  end
end

module ControlByFiles
  module Controllers
    class Rake < Base
      begin
        require 'StringIO'
      rescue LoadError => e
        require 'stringio'
      end
      require 'open3'
      
      def file
        'rake.txt'
      end
      
      def handle_file
        response = "\n\nResponse:\n\n"
        
        content = read_file
        content.split("\n").each do |line|
          if line.strip.chomp.size > 0
            cmd = "rake #{line}"
            response += "Running: #{cmd}\n"
            response += "=" * 80 + "\n"
            
            buffer_in, buffer_out, buffer_err = Open3.popen3 'rake', line
            
            response += buffer_out.read.to_s + buffer_err.read.to_s
            response += '-' * 80 + "\n" * 2
          end
        end
        
        append_to_file {|file| file.puts response}
      end
    end
  end
end

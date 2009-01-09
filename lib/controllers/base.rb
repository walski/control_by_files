module ControlByFiles
  module Controllers
    class Base
      def rooted_file
        "#{RAILS_ROOT}/tmp/#{file}"
      end
      
      def file_exists?
        File.exists?(rooted_file)
      end
      
      def needs_run?
        File.exists?(rooted_file) && read_file.split("\n").last !~ /^FINISHED: /
      end
      
      def run
        return unless needs_run?
        handle_file
        append_to_file {|f| f.puts "FINISHED: #{Time.now}"} if file_exists?
      end
      
      def read_file
        return @content if @content
        @content = ""
        File.open(rooted_file, 'r') do |input|
          while !input.eof?
            @content += "#{input.gets}\n"
          end
        end
        @content
      end
      
      def write_file
        File.open(rooted_file, 'w') do |output|
          yield output
        end
      end
      
      def append_to_file
        File.open(rooted_file, 'a') do |output|
          yield output
        end
      end
      
      def delete_file!
        File.delete(rooted_file)
      end
      
    end
  end
end

# Top-level class to provide approval test support (inspired by http://approvaltests.com/)
class Approvals
  class << self
    def verify(rendered_content, approved_path, **options)
      scrubbed_content = apply_optional_scrubber(rendered_content, options)
      pre_approve_if_asked(approved_path, scrubbed_content, options)

      expected_content = load_expected_content(approved_path, **options)
      received_path = received_path_for approved_path

      if scrubbed_content.strip.empty?
        raise_verify_error_with_diff(approved_path, received_path, scrubbed_content, **options) unless options[:allow_empty]
      elsif scrubbed_content.strip == expected_content.strip
        handle_match(received_path, scrubbed_content, **options)
      else
        raise_verify_error_with_diff(approved_path, received_path, scrubbed_content, **options)
      end
    end

    private

    def apply_optional_scrubber(content, **options)
      if options.key?(:scrubber) && options[:scrubber]
        options[:scrubber].call(content)
      else
        content
      end
    end

    def pre_approve_if_asked(approved_path, scrubbed_content, **options)
      File.write(approved_path, scrubbed_content) if options[:approve_all] || options[:accept_all]
    end

    def handle_match(received_path, received_content, **options)
      if options[:keep_received_file] == true
        File.write(received_path, received_content)
      elsif File.file?(received_path)
        File.delete received_path
      end
    end

    def received_path_for(approved_path)
      "#{approved_path}.received"
    end

    def load_expected_content(approved_path, **options)
      if File.file? approved_path
        File.read(approved_path)
      else
        File.open(approved_path, 'w') { |f| f.write('') } if options[:create_if_missing]
        ''
      end
    end

    def raise_verify_error_with_diff(approved_path, received_path, received_content, **options)
      File.write(received_path, received_content)

      # and generate a diff for the console
      message = options[:message_override] || %(Approval failed to match "#{approved_path}")
      message << "\n"
      message << %(- writing received content to: "#{received_path}")
      message << "\n"

      expected_content = load_expected_content(approved_path)
      ::RSpec::Expectations.fail_with message, expected_content, received_content
    end
  end
end

# frozen_string_literal: true

require_relative '../constants/famitracker'

# parse famitracker files line by line
module FamiTrackerFileParser
  include FamiTrackerConstants

  class << self
    attr_accessor :current_line, :parsed_blocks

    def parse(file)
      file_blocks = {}
      parsed_blocks = []

      file.each { |line| process_line line, file_blocks }

      file_blocks.each_pair do |key, val|
        method = "parse_#{key}".to_sym
        parsed = send(method, key, val) if respond_to?(method, true)
        parsed_blocks.push(parsed) if parsed
      end

      pp parsed_blocks
    end

    private

    def block_header_to_sym(header)
      header.downcase.tr('#', '').strip.tr(' ', '_').to_sym
    end

    def process_line(line, file_blocks)
      if line[0] == '#'
        block_name = block_header_to_sym(line)

        if FamiTrackerConstants::BLOCKS.include? block_name
          file_blocks[block_name] = []
          self.current_line = block_name
        end
      else
        current_block = file_blocks[current_line]
        (current_block && current_block.length < 10 && line.length > 0) && current_block.push(line.strip)
      end
    end

    def parse_song_information(name, block)
      block_definition = FamiTrackerConstants::BLOCK_DEFS[name]
      mapped_block = block.map do |string|
        string.squeeze(' ').gsub('"', '').split(' ', 2)
      end.to_h

      filter_hash_by_keys(mapped_block, block_definition)
    end

    def parse_song_comment(*args)
      parse_song_information(*args)
    end

    def parse_global_settings(*args)
      parse_song_information(*args)
    end

    def filter_hash_by_keys(hash, acceptable_keys)
      hash.each_key do |key|
        hash.delete(key) unless acceptable_keys.include? key
      end

      hash
    end
  end
end

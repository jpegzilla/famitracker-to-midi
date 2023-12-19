# frozen_string_literal: true

require 'midilib/io/seqwriter'
require 'midilib/sequence'
require 'midilib/consts'

require_relative 'lib/constants/famitracker'
require_relative 'lib/constants/midi'
require_relative 'lib/utils/famitracker_file_parser'

# famitracker to midi main module
module FamiTrackerToMidi
  include MIDI

  file_path = ARGV[0]

  puts "file_path => #{file_path}"

  FamiTrackerFileParser.parse File.readlines(file_path, chomp: true)

  midi_sequence = Sequence.new
  track = Track.new(midi_sequence)
  midi_sequence.tracks << track
  track.events << Tempo.new(Tempo.bpm_to_mpq(120))

  # puts "midi_sequence => #{midi_sequence}"
end

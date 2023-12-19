# frozen_string_literal: true

module FamiTrackerConstants
  BLOCKS = %i[
    song_information
    song_comment
    global_settings
    macros
    dpcm_samples
    instruments
    tracks
    end_of_export
  ].freeze

  BLOCK_DEFS = {
    song_information: %w[
      TITLE
      AUTHOR
      COPYRIGHT
    ],
    song_comment: %w[
      COMMENT
    ],
    global_settings: %w[
      MACHINE
      FRAMERATE
      EXPANSION
      VIBRATO
      SPLIT
    ],
    macros: %w[],
    dpcm_samples: %w[],
    instruments: %w[]
  }.freeze
end

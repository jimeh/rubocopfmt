module RuboCopFMT
  RUBOCOP_VERSION = [
    # Ten minor versions back is all we bother supporting.
    '>= 0.38.0',

    # Errors occur in the the Rails/UniqBeforePluck cop.
    '!= 0.41.0',

    # Fails unless pry gem is installed separately.
    '!= 0.44.0',

    # Restrict to latest version tested.
    '< 0.57'
  ].freeze
end

module Opentrink
  module Emoji
    extend self

    ALPHABET_PATH = Pathname.new(__FILE__).dirname.join('emoji_alphabet.json')
    def alphabet
      @alphabet ||= JSON.load_file(ALPHABET_PATH).shuffle(random: Random.new(3))
    end
  end
end

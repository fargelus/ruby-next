# frozen_string_literal: true

# Refine Array seprately, 'cause refining modules is vulnerable to prepend:
# - https://bugs.ruby-lang.org/issues/13446
RubyNext::Core.patch Enumerable,
  name: "Enumerable",
  version: "2.7",
  supported: [].respond_to?(:tally),
  location: [__FILE__, __LINE__ + 3],
  refineable: [Enumerable, Array] do
  <<~RUBY
    def tally
      each_with_object({}) do |v, acc|
        acc[v] ||= 0
        acc[v] += 1
      end
    end
  RUBY
end

 class Sentence
 	def initialize(name,content)
 		@name = name
 		@content = content
 	end
 	def name
 		@name
 	end
 	def content
 		@content
 	end

 end

 class SentencePersistence
 	def add(sentence)

 		File.open(file_name,"w+") do |file|
 			file.write(sentence.content())
 		end
 	end
 	def to_s
 		"<An instance of sentence persistence>"
 	end

 end

 class SentenceUi
 	def initialize(sentence_store,io)
 		@store = sentence_store
 		@io = io
 	end
 	def main_menu
 		@io.puts("Welcome to sentence store v1")
 		@io.puts("Do you want to (s) store a sentence (r) retrieve a sentence?:")

 		answer = gets().chomp().downcase()

 		if answer == "s"
 			puts("Name of sentence")
			sentence_name = gets().chomp()

			puts("Content of sentence")
			sentence_content = gets().chomp()

			sentence = Sentence.new(sentence_name,sentence_content)

			@store.add(sentence)

			puts("Sentence #{sentence.name()} has been stored!")

 		elsif answer == "r"

 			# ask store to retrieve sentence given it's name
 			puts("Name of sentence")
 			sentence_name = gets().chomp()
 			# give nice error message if we don't know about the sentence
 			unless Sentence.retrieve(sentence_name)
 				abort("Sentence '#{sentence_name}' does not exist, sorry!")
 			end
 			# display sentence in some format to user
 			puts ("Your sentence is #{sentence_content}")

 		elsif answer == "l"

 			# list all sentences present
 			new_sentence = SentencePersistence.new()
 			
 			puts ("#{new_sentence}")

 			# or tell user if there are none
 			unless new_sentence = nil
 				abort("There are no sentences to print!")
 			end

 		else 
 			@io.puts("Sorry I have no idea how to #{answer} a sentence")
 		end
 	end
 end

 def main(io)

 	sentence_ui = SentenceUi.new(
 		SentencePersistence.new(),
 		io
 		)

 	sentence_ui.main_menu()

 end

 main(STDOUT)

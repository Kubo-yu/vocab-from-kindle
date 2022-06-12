require "csv"

module Import
  class ImportCsv
    def self.import(file)  # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      vocabulary_rows = 4
      csv = CSV.read(file.path, liberal_parsing: true)
      # # 1つ空白追加
      # csv.to_a.insert(6, '')
      # book、author作成
      title = csv[1][0]
      author = csv[2][0].gsub(/by\s/, '')
      book = Book.find_or_create_by!(title: title)
      author = Author.find_or_create_by!(name: author)
      AuthorBook.find_or_create_by!(book_id: book.id, author_id: author.id)

      # vocab作成
      csv.each_slice(2).with_index do |rows, index|
        if index >= vocabulary_rows
          example = rows[0][3]
          word_or_words = rows[1][3]
          # 1つのexampleに対して、2つ以上のwordの場合
          if word_or_words.match?(/s*,\ss*/)
            words = word_or_words.split(/s*,\ss*/)
            words.each do |word|
              Vocabulary.create!(example: example, word: word, book_id: book.id)
            end
          # 1つのexampleに対して、1つのwordの場合
          else
            vacab = Vocabulary.new
            if rows[0][0] == 'Highlight (Yellow)' && rows[1][0] == 'Note'
              vacab.example = example
              vacab.word = rows[1][3].gsub(/\s$/, '')
              vacab.book_id = book.id
              vacab.save!
            end
          end
        end
      end
    end
  end
end

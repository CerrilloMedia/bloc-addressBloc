require_relative 'entry'
require "csv"

    class AddressBook
        
        attr_reader :entries
        
        def initialize
           @entries = []
        end
        
        def add_entry(name, phone_number, email)
            index = 0
            # find proper index of name within the lexicographical order or data
            entries.each do |entry|
               if name < entry.name
                   break
               end
               index+= 1
            end
            
            entries.insert(index, Entry.new(name, phone_number, email))
        end
        
        def import_from_csv(file_name)
           # Implementation goes here 
           csv_text = File.read(file_name)
           
           #Use parse to parse from CSV::Table
           # (headers = true) specifies 1st row of data as headers so long as they match
           csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
           
           csv.each do | row |
               row_hash = row.to_hash
               add_entry(row_hash["name"],row_hash["phone_number"],row_hash["email"])
           end
           
        end
        
        def remove_entry(name, phone_number, email)
            index = entries.index { | entry |
                entry.name == name && entry.phone_number == phone_number && entry.email == email
            }
            entries.slice!(index,1)
        end
        
    end

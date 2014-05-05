task :addDate => :environment do
  JournalEntry.all.each do |entry|
    date = Date.parse(entry.created_at.to_s)
    date.strftime('%Y-%m-%d')
    entry.update(date: date)
  end
end


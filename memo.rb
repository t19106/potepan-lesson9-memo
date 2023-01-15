require "csv"

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
puts "3 → 既存メモを閲覧する"
memo_type = gets.to_i

if memo_type == 1
    puts "拡張子を除いたファイルを入力してください"
    name = gets.chomp
    puts "メモしたい内容を入力してください"
    puts "完了したら Ctrl + D を押します"
    input = readlines
    CSV.open("#{name}.csv",'w') do |test|
        test << input
    end
    puts "下記の内容を保存しました："
    puts "----------"
    CSV.foreach("#{name}.csv") do |row|
        puts row
    end
elsif memo_type == 2
    puts "拡張子を除いたファイルを入力してください"
    name = gets.chomp
    if File.exist?("#{name}.csv")
        puts "編集方法を入力してください"
        puts "1 → メモの内容を全て上書きする / 2 → メモに追記する"
        puts "3 → プログラムを終了する"
        puts "注意： 上書き・追尾後はやり直せません"
        edit_type = gets.to_i
        if (1..3) === edit_type
            puts "メモしたい内容を入力してください"
            puts "完了したら Ctrl + D を押します"
            input = readlines
            if edit_type == 1
                CSV.open("#{name}.csv",'w') do |test|
                    test << input
                end
            elsif edit_type == 2
                CSV.open("#{name}.csv",'a') do |test|
                    test << input
                end
            end
            puts "下記の内容を保存しました："
            puts "----------"
            CSV.foreach("#{name}.csv") do |row|
                puts row
            end
        else
            puts "該当する選択肢がありませんでした"
        end
    else
        puts "該当するメモファイルが存在しません"
    end
elsif memo_type == 3
    puts "拡張子を除いたファイルを入力してください"
    name = gets.chomp
    unless File.exist?("#{name}.csv")
        puts "該当するメモファイルが存在しません"
    else
        puts "メモの内容を表示します："
        puts "----------"
        CSV.foreach("#{name}.csv") do |row|
            puts row
        end
    end
else
    puts "該当する選択肢がありませんでした"
end
puts "----------"
puts "アプリを終了します。"
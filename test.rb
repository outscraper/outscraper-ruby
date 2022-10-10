require 'Outscraper'

client = Outscraper::Client.new('YXV0aDB8NjAyMDFmODYwOTQ5M2UwMDZhOGM4YjZhfDhkMjQ2NDQ1Nzc')
p client.google_search('buy iphone 13 TX', language: 'en', region: 'us')
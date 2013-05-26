json.array!(@microposts) do |micropost|
  json.extract! micropost, :post, :user_id
  json.url micropost_url(micropost, format: :json)
end
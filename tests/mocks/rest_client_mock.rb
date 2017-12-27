class RestClientMock
  def self.get(endpoint)
    images_response = OpenStruct.new
    images_response.body = '{ 
      "images": [
        {"url": "http://54.152.221.29/images/b737_5.jpg"},
        {"url": "http://54.152.221.29/images/b777_5.jpg"},
        {"url": "http://54.152.221.29/images/b737_3.jpg"},
        {"url": "http://54.152.221.29/images/b777_4.jpg"},
        {"url": "http://54.152.221.29/images/b777_3.jpg"},
        {"url": "http://54.152.221.29/images/b737_2.jpg"},
        {"url": "http://54.152.221.29/images/b777_2.jpg"},
        {"url": "http://54.152.221.29/images/b777_1.jpg"},
        {"url": "http://54.152.221.29/images/b737_4.jpg"},
        {"url": "http://54.152.221.29/images/b737_1.jpg"}
    ]}'

    results = { 
       'http://foo/images.json' => images_response
    }

    results[endpoint]   
  end
end
require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  include Rack::Test::Methods

  let(:app) { Application.new }

  context "GET /" do
    it 'contains a h1 title' do
      response = get('/')
  
      expect(response.body).to include('<h1>Hello !</h1>')
    end
    
    it 'contains a div' do
      response = get('/')
  
      expect(response.body).to include('<div>')
    end

    it "returns hello {param}" do
      response = get('/hello', name: "Matt")
      expect(response.status).to eq(200)
      expect(response.body).to include ("Hello Matt!")
    end

    it "returns name and message" do
      response = post('/submit', name: "Matt", message: "Hello, World")
      expect(response.status).to eq(200)
      expect(response.body).to eq("Thanks Matt, you sent this message: Hello, World")
    end

    it "returns 200 OK" do
      # Assuming the post with id 1 exists.
      response = get('/names', name_list: "Julia, Mary, Karim")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /" do
    it "returns sorted list of names" do
      response = post('/sort_names', names: "Joe,Alice,Zoe,Julia,Kieran")

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  end
end

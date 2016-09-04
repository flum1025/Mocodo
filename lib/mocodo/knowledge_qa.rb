module Mocodo
  class KnowledgeQA < Base
    EndPoint = "/knowledgeQA/v1/ask"
    
    def create_qa text
      uri = build_url(EndPoint, q: URI.encode(text))
      JSON.parse(open(uri).read)
    end
  end
end
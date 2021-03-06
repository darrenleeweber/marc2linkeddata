require_relative 'oclc_resource'

module Marc2LinkedData

  class OclcCreativeWork < OclcResource

    PREFIX = 'http://www.worldcat.org/oclc/'

    def get_works
      # assume an exampleOfWork can only ever link to one work?
      q = query_work(@iri)
      works = rdf.query(q).collect {|s| s[:o] }
      if works.empty?
        # OCLC data is inconsistent in use of 'www.' in IRI, so try again.
        # The OclcResource coerces @iri so it includes 'www.', so try without it.
        uri = @iri.to_s.gsub('www.','')
        q = query_work(uri)
        works = rdf.query(q).collect {|s| s[:o] }
      end
      if works.empty?
        # Keep the 'www.', cast the ID to an integer.
        uri = @iri.to_s.gsub(id, id.to_i.to_s)
        q = query_work(uri)
        works = rdf.query(q).collect {|s| s[:o] }
      end
      if works.empty?
        # Remove the 'www.' AND cast the ID to an integer.
        uri = @iri.to_s.gsub('www.','').gsub(id, id.to_i.to_s)
        q = query_work(uri)
        works = rdf.query(q).collect {|s| s[:o] }
      end
      works
    end

    def query_work(uri)
      SPARQL.parse("SELECT * WHERE { <#{uri}> <http://schema.org/exampleOfWork> ?o }")
    end

    # TODO: get ISBN?

  end

end


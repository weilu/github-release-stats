require "thor"
require "open-uri"
require "json"

module Github
  module Release
    module Stats

      class Cli < Thor
        desc "downloads <owner/project>", "get download stats for all releases of project <owner/project>"
        def downloads(repo)
          url = "https://api.github.com/repos/#{repo}/releases"
          releases = JSON.parse open(url).read

          prod_releases =  releases.select do |r|
            !r["draft"] && !r["prerelease"] && r["assets"] && !r["assets"].empty?
          end

          stats = prod_releases.map do |r|
            [r["tag_name"], r["assets"].first["download_count"]]
          end

          # puts stats
          stats
        end
      end

    end
  end
end

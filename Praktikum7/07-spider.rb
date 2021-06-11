# !/usr/bin/env ruby
# Otto Santovenia, Luis Manuel Alfred, 1190173, 03.06.2021
require 'uri'
require 'net/http'
require 'timeout'
require 'thread'

COUNTER_LIMIT = 100
POOL_SIZE = 10


class Crawler

    def initialize(uri)
        
        $visited = []
        $to_visit = []
        $http_start_reg = /^http.?:\/\//
        $tag_link_reg = /<a.*?href="(.+?)".*?>.*?<\/a>/im
        $tag_start_reg = /<(?!!)[^\/^>]+>/
        $tag_end_reg = /<\/.+?>/
        $tag_comments_reg = /<!--.*?-->/
        $tag_empty_reg = /<(?!!)[^\/^>]+\/>/
        $timeout_in_seconds = 5
        
        visit_loop(uri)
        print_end_stats
    end

    def visit_loop(url)
        $v_mutex = Mutex.new
        $work_q = Queue.new
        $work_q.push(url)
        workers = (POOL_SIZE).times.map do
            Thread.new do
                begin
                    while $visited.length() < COUNTER_LIMIT && x = $work_q.pop(false)
                        parse_page(x) if x != nil
                    end
                rescue ThreadError
                    puts "Error in Thread"
                end
            end
        end
        workers.map(&:join)
    end

    def parse_page(url)
        $skip_len = false
        begin
            page = Net::HTTP.get(URI.parse(url))
        rescue => exception
            puts "Error @ retriving #{url}"
            $skip_len = true
            return false
        end
        page.gsub!("\n","")
        get_new_links(page, url)
        print_statistics(page, url) if $skip_len == false
    end
    def get_new_links(webpage,url)
        links = "";
        begin
            status = Timeout::timeout(5) {
                links = webpage.scan($tag_link_reg)
            }
        rescue => exception
            $skip_len = true
            return
        end
        url_data = URI(url)
        links.each do |l|
            uri = l[0]
            if uri[0..1] == ".." 
                $skip_op = true
                return false
            end
            uri.prepend(url_data.scheme,"://",url_data.host) if !$http_start_reg.match?(uri)
            
            uri.concat("/") if uri[-1] != "/"

            if(!$to_visit.include?(uri) && !$visited.include?(uri) && !uri[-4...-1].match?(/jpg|png/))
                $work_q.push(uri)
                $to_visit.push(uri)
            end
        end
        $v_mutex.lock
        $visited.append(url) if !$visited.include?(url)
        $v_mutex.unlock
    end
    def print_statistics(page,url)
        comments,end_tags,emtpy_tags,start_tags,link_tags = ""
        begin
            status = Timeout::timeout(5) {
                comments = page.scan($tag_comments_reg) 
                end_tags = page.scan($tag_end_reg)
                emtpy_tags = page.scan($tag_empty_reg)
                start_tags = page.scan($tag_start_reg)
                link_tags = page.scan($tag_link_reg)        
            }
        rescue => exception
            return
        end

        puts "","Now visiting: #{url}"
        puts "# of Comments:#{comments.length()}","# of start tags:#{start_tags.length()}"
        puts "# of end tags:#{end_tags.length()}","# of empty tags:#{emtpy_tags.length()}", "# of links:#{link_tags.length()}"        
    end
    def print_end_stats
        puts "","found #{$visited.length()+$to_visit.length()} Websites\nvisited #{$visited.length()} Websites", "List of Sites visited:#{$visited}"
    end
   
end

trap "SIGINT" do
    puts "","Stoping!", "found #{$visited.length()+$to_visit.length()} Websites\nvisited #{$visited.length()} Websites", "List of Sites visited:#{$visited}"
    exit 
end

if ARGV[0] == nil
    puts "Usage: [ruby] 07-spider.rb URL"
    exit
end

c = Crawler.new(ARGV[0])

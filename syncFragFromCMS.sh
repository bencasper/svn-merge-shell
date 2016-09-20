#!/bin/sh
includePath=/letv/data/include/
checkVal=0
syncByWget(){
	filename=$1
	cmsPath=$2
	tempFilename=$3
        wget -O $includePath$tempFilename  $cmsPath
	
	if [ $? -eq 0 ]
	then
        	mv $includePath$tempFilename $includePath$filename
        	rm -f $includePath$tempFilename
	fi
	checkVal=$(( $checkVal + $? ))
}
#动漫排行榜
syncByWget "topcomic.inc" "http://comic.letv.com/commonfrag/channel/comic_topAll_album.inc" "topcomic_temp" 
#电视剧排行榜
syncByWget "toptv.inc" "http://tv.letv.com/commonfrag/channel/tv_topAll.inc" "toptv_temp"
#电影排行榜
syncByWget "topmovie.inc"  "http://movie.letv.com/commonfrag/channel/film_topAll.inc" "topmovie_temp"
#纪录片排行榜
syncByWget "topdocumentary.inc" "http://jilu.letv.com/commonfrag/channel/jilu_top_detail.inc" "topjilu_temp"
#公共头部
syncByWget "header_detail.inc" "http://tv.letv.com/commonfrag/sub_small_head_html.inc" "header_temp"
#公共尾部
syncByWget "footer_detail.inc" "http://tv.letv.com/commonfrag/sub_small_foot_html.inc" "footer_temp"
#abc.js
syncByWget "abc_js.inc" "http://tv.letv.com/commonfrag/sub_js.inc" "abc_temp"
#sub_ad.js
syncByWget "sub_ad_js.inc" "http://www.letv.com/commonfrag/sub_ad_js.inc" "sub_ad_temp"
#top.css
syncByWget "top_css.inc" "http://tv.letv.com/commonfrag/sub_small_css_top.inc" "top_temp"
#detail_css
syncByWget "detail_css.inc" "http://tv.letv.com/commonfrag/detail_css.inc" "detail_css_temp"
#resp_css
syncByWget "sub_resp.inc" "http://tv.letv.com/commonfrag/sub_resp.inc" "sub_resp_temp"
echo $checkVal

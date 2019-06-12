/*
 MIT License
 
 Copyright (c) 2018 NUM Technology Ltd
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
 documentation files (the "Software"), to deal in the Software without restriction, including without limitation
 the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
 to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of
 the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
 WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
 OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
 OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

//
//  LongInputTests.swift
//  MODL-SwiftTests
//
//  Created by Nicholas Jones on 08/05/2019.

import XCTest
@testable import MODL_Interpreter

class LongInputTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testlongInput() {
        let modl = LongTest.text
        let p = Interpreter()
        do {
            let result = try p.parseToJson(modl)
            print(result)
        } catch {
            XCTFail("Parse error: \(error.localizedDescription)")
        }
    }
}

fileprivate struct LongTest {
    static let text = """
## Only an entity or an array of entities can be at the root
## of a NUM MODL object.
*class(
  *id=root
  *name=root
  *superclass=arr
  *allow=[entity]
)

## All maps that are allowed in NUM are an object of some kind
*class(
  *id=object
  *name=object
  *superclass=map
  *allow=[i;h;q;c_;r_;tz]
)

## ENTITY: Someone or something to make contact with
*class(
  *id=entity
  *name=entity
  *superclass=object
  *assign=[
    [n]
    [n;q]
##    [n;q;d]
##    [n;q;d;h;tz]
  ]
  *allow=[n;+]
)

## MEDIUM: A way to make contact with an entity

*class(
  *id=medium
  *name=medium
  *superclass=object
  *assign=[
    ## value, e.g. '441270123456'
    [v]
    ## description and value, e.g. 'Sales:441270123456'
    [d;v]
    ## description, value and available hours, e.g. 'Sales:441270123456:wd@9-17'
    [d;v;h]
  ]
  *allow=[v;ac]
)

*class(
  ## EXTENSION: A way to offer DNS/Web-based services, e.g. store locator
  *id=x
  *name=extension
  *superclass=map
  *allow=[url;pa]
)

## ALL OBJECTS CAN BE DESCRIBED WITH THESE KEYS:
*class(
  ## INTRODUCTION: Introductory text for a NUM record
  *id=i
  *name=introduction
  *superclass=str
)

*class(
  ## HOURS: The hours that an entity or medium is available
  *id=h
  *name=hours
  *superclass=arr
  *allow=[str]
)

*class(
  ## TIME_ZONE_CITY: The default time zone city for an object
  *id=tz
  *name=time_zone_city
  *superclass=str
)

*class(
  ## QUERY: Instructs the NUM client to make another query
  *id=q
  *name=query
  *superclass=str
)

*class(
  ## CONTINUATION: The record continues at another DNS location
  *id=c_
  *name=continuation_
  *superclass=str
)

*class(
  ## REDIRECT: The client should be redirected to a branch record
  *id=r_
  *name=redirect_
  *superclass=str
)

*class(
  ## PERSON: A person to contact
  *id=p
  *name=person
  *superclass=entity
  *allow=[b]
  object_type=entity
  object_display_name=Person
)

*class(
  ## ORGANISATION: An organisation to make contact with
  *id=o
  *name=organisation
  *superclass=entity
  *assign=[
    ## name, 'Tesco'
    [n]
    ## name and objects 'Tesco:[t=44800 50 5555]'
    [n;+]
    ## name, slogan and objects 'Tesco:Every Little Helps:[t=44800 50 5555]'
    [n;s;+]
    ## object index, name, slogan and objects 'tesco:%1.s:Every Little Helps:[t=44800 50 5555;fb=%1]'
    [?;n;s;+]
    ## ojbect index, name, slogan, available hours and objects 'tesco:%1.s:Every Little Helps:d@6-24:[t=44800 50 5555;fb=%1]'
    [?;n;s;h;+]
  ]
  *allow=[s]
  object_type=entity
  object_display_name=Organisation
  description_default=View Organisation
)

*class(
  ## DEPARTMENT: A department within an organisation
  *id=dp
  *superclass=entity
  *name=department
  *allow=[d]
  object_type=entity
  object_display_name=Department
  description_default=View Department
)

*class(
  ## EMPLOYEE: An employee of an organisation to contact
  *id=e
  *superclass=entity
  *name=employee
  ## An employee object can be instantiated with keyless
  ## pairs by submitting values in this order:
  ## Name:Role, e.g:
  ## John Smith:Managing Director
  *assign=[
    ## name, e.g. John Smith
    [n]
    ## name and role, e.g. John Smith:Managing Director
    [n;r]
  ]
  *allow=[r]
  object_type=entity
  object_display_name=Employee
  description_default=View Employee
)

*class(
  ## LOCATION: e.g. a company store
  *id=l
  *superclass=entity
  *name=location
  *allow=[d]
  object_type=entity
  object_display_name=Location
)

*class(
  ## FOLDER: A folder containing more contact information
  *id=f
  *superclass=entity
  *name=folder
  *allow=[d]
  object_type=entity
  object_display_name=Folder
)

## These keys are used for all entities
*class(
  ## ENTITY NAME: e.g. 'Tesco' or 'John Smith'
  *id=n
  *name=name
  *superclass=str
)

*class(
  ## OBJECTS: A list of objects
  *id=+
  *name=objects
  *superclass=arr
  *name=objects
  *allow=[object]
)

## Biography is just for person
*class(
  ## BIOGRPAHY: Brief info about a person
  *id=b
  *name=bio
  *superclass=str
)

## Slogan is just for organisations
*class(
  ## SLOGAN: The organisation slogan, e.g. 'Every Little Helps'
  *id=s
  *name=slogan
  *superclass=str
)

## Description is for departments, locations and folders
*class(
  ## DESCRIPTION: A description of a medium, e.g 'Customer Service'
  *id=d
  *name=description
  *superclass=str
)

## Role is just for employees
*class(
  ## ROLE: An employee's role at an organisation
  *id=r
  *name=role
  *superclass=str
)

## These are just for media
*class(
  ## VALUE: A medium value, e.g. a telephone number
  *id=v
  *name=value
  *superclass=str
)

*class(
  ## ACCESSIBILITY: Provides accessibility information for media
  *id=a
  *name=access
  *superclass=arr
  *allow=[str]
)

*class(
  ## TELEPHONE: A telephone number in E.164 (https://en.wikipedia.org/wiki/E.164) format
  *id=t
  *name=telephone
  *superclass=medium
  object_type=medium
  object_display_name=Telephone
  description_default=Call
  prefix="tel://"
  media_type=core
)

*class(
  ## SMS: An SMS number for enquiries in E.164 (https://en.wikipedia.org/wiki/E.164) format
  *id=sm
  *name=sms
  *superclass=medium
  object_type=medium
  object_display_name=SMS
  description_default=Text
  prefix="sms://"
  media_type=core
)

*class(
  ## URL: The organisation's webpage or a webpage about a particular topic or product.
  *id=u
  *name=url
  *superclass=medium
  object_type=medium
  object_display_name=URL
  description_default=Click
  prefix="https://"
  media_type=core
)

*class(
  ## UNSECURE_URL: The organisation's webpage or a webpage about a particular topic or product.
  *id=uu
  *name=unsecure_url
  *superclass=medium
  object_type=medium
  object_display_name=URL
  description_default=Click
  prefix="http://"
  media_type=core
)

*class(
  ## GPS: GPS co-ordinates in WGS84 (https://en.wikipedia.org/wiki/World_Geodetic_System) format
  ## e.g. the location of a store or office. It's also possible to optionally show how a GPS location
  ## can be accessed (e.g. on foot / bicycle / wheelchair / car), for more information see accessibility
  *id=g
  *name=gps
  *superclass=medium
  object_type=medium
  object_display_name=GPS
  description_default=View Address
  prefix=Based on user preferences set in client.
  media_type=core
)

*class(
  ## ADDRESS: A land / postal address.
  *id=a
  *name=address
  *superclass=medium
  object_type=medium
  object_display_name=Address
  description_default=View Address
  prefix=Based on user preferences set in client.
  media_type=core
)

*class(
  ## FAX: A number for fax transmission in E.164 (https://en.wikipedia.org/wiki/E.164) format
  *id=fx
  *name=fax
  *superclass=medium
  object_type=medium
  object_display_name=Fax
  description_default=Send a fax
  prefix=Based on user preferences set in client.
  media_type=core
)

*class(
  ## EMAIL: An email address for enquiries. We do not recommend listing an email in the DNS.
  *id=em
  *name=email
  *superclass=medium
  object_type=medium
  object_display_name=Email
  description_default=Send an email
  prefix="mailto://"
  media_type=core
)

*class(
  ## ANDROID APP: A download link for an app on the Google Play store.
  *id=aa
  *name=android-app
  *superclass=medium
  object_type=medium
  object_display_name=Android App
  description_default=Download the app
  prefix="https://play.google.com/store/apps/details?id="
  media_type=3p
)

*class(
  ## IOS APP: A download link for an app on the Apple App Store.
  *id=as
  *name=ios-app
  *superclass=medium
  object_type=medium
  object_display_name=iOS App
  description_default=Download the app
  prefix="https://itunes.apple.com/app/"
  media_type=3p
)

*class(
  ## BAIDU TIEBA
  *id=bt
  *name=baidu_tieba
  *superclass=medium
  object_type=medium
  object_display_name=Baidu Tieba
  description_default=View Baidu profile
  prefix="https://tieba.baidu.com/"
  media_type=3p
)

*class(
  ## FACEBOOK
  *id=fb
  *name=facebook
  *superclass=medium
  object_type=medium
  object_display_name=Facebook
  description_default=View Facebook profile
  prefix="https://www.facebook.com/"
  media_type=3p
)

*class(
  ## FLIKR
  *id=fk
  *name=flikr
  *superclass=medium
  object_type=medium
  object_display_name=Flikr
  description_default=View Flikr profile
  prefix="https://www.flikr.com/"
  media_type=3p
)

*class(
  ## FOURSQUARE
  *id=fs
  *name=foursquare
  *superclass=medium
  object_type=medium
  object_display_name=FourSquare
  description_default=View FourSquare page
  prefix="https://www.foursquare.com/"
  media_type=3p
)

*class(
  ## FACETIME
  *id=ft
  *name=facetime
  *superclass=medium
  object_type=medium
  object_display_name=FaceTime
  description_default=Call with FaceTime
  prefix="facetime://"
  media_type=3p
)

*class(
  ## GOOGLE PLUS
  *id=gp
  *name=google-plus
  *superclass=medium
  object_type=medium
  object_display_name=Google Plus
  description_default=View Google Plus profile
  prefix="https://plus.google.com/"
  media_type=3p
  value_prefix=+
)

*class(
  ## IMESSAGE
  *id=im
  *name=imessage
  *superclass=medium
  object_type=medium
  object_display_name=iMessage
  description_default=Send iMessage
  prefix="imessage://"
  media_type=3p
)

*class(
  ## INSTAGRAM
  *id=in
  *name=instagram
  *superclass=medium
  object_type=medium
  object_display_name=Instagram
  description_default=View Instagram profile
  prefix="https://www.instagram.com/"
  media_type=3p
)

*class(
  ## KIK
  *id=kk
  *name=kik
  *superclass=medium
  object_type=medium
  object_display_name=Kik
  description_default=Connect with Kik
  prefix="https://www.kik.com/u/"
  media_type=3p
)

*class(
  ## LINKEDIN
  *id=li
  *name=linkedin
  *superclass=medium
  object_type=medium
  object_display_name=LinkedIn
  description_default=View LinkedIn page
  prefix="https://www.linkedin.com/"
  media_type=3p
)

*class(
  ## LINE
  *id=ln
  *name=line
  *superclass=medium
  object_type=medium
  object_display_name=LINE
  description_default=Connect with Line
  prefix="line://"
  media_type=3p
)

*class(
  ## MEDIUM
  *id=md
  *name=medium
  *superclass=medium
  object_type=medium
  object_display_name=Medium
  description_default=View Medium blog
  prefix="https://www.medium.com/"
  media_type=3p
)

*class(
  ## PERISCOPE
  *id=pr
  *name=periscope
  *superclass=medium
  object_type=medium
  object_display_name=Periscope
  description_default=View Periscope profile
  prefix="https://www.periscope.tv/"
  media_type=3p
)

*class(
  ## PINTEREST
  *id=pi
  *name=pinterest
  *superclass=medium
  object_type=medium
  object_display_name=Pinterest
  description_default=View Pinterest board
  prefix="https://www.pinterest.com/"
  media_type=3p
)

*class(
  ## QQ
  *id=qq
  *name=qq
  *superclass=medium
  object_type=medium
  object_display_name=QQ
  description_default=View QQ Page
  prefix="https://www.qq.com/"
  media_type=3p
)

*class(
  ## QZONE
  *id=qz
  *name=qzone
  *superclass=medium
  object_type=medium
  object_display_name=Qzone
  description_default=View Qzone page
  prefix="https://www.qzone.com/"
  media_type=3p
)

*class(
  ## REDDIT
  *id=rd
  *name=reddit
  *superclass=medium
  object_type=medium
  object_display_name=Reddit
  description_default=View subreddit
  prefix="https://www.reddit.com/r/"
  media_type=3p
)

*class(
  ## RENREN
  *id=rn
  *name=renren
  *superclass=medium
  object_type=medium
  object_display_name=Renren
  description_default=View Renren profile
  prefix="https://www.renren.com/"
  media_type=3p
)

*class(
  ## SOUNDCLOUD
  *id=sc
  *name=soundcloud
  *superclass=medium
  object_type=medium
  object_display_name=SoundCloud
  description_default=View SoundCloud page
  prefix="https://www.soundcloud.com/"
  media_type=3p
)

*class(
  ## SKYPE
  *id=sk
  *name=skype
  *superclass=medium
  object_type=medium
  object_display_name=Skype
  description_default=Call with Skype
  prefix="skype://"
  media_type=3p
)

*class(
  ## SWARM
  *id=sr
  *name=swarm
  *superclass=medium
  object_type=medium
  object_display_name=Swarm
  description_default=Connect with Swarm
  prefix="https://www.swarmapp.com/"
  media_type=3p
)

*class(
  ## SNAPCHAT
  *id=sn
  *name=snapchat
  *superclass=medium
  object_type=medium
  object_display_name=Snapchat
  description_default=Connect with Snapchat
  prefix="snapchat://add/"
  media_type=3p
)

*class(
  ## SINA WEIBO
  *id=sw
  *name=sina-weibo
  *superclass=medium
  object_type=medium
  object_display_name=Sina Weibo
  description_default=View Weibo page
  prefix="https://www.weibo.com/"
  media_type=3p
)

*class(
  ## TUMBLR
  *id=tb
  *name=tumblr
  *superclass=medium
  object_type=medium
  object_display_name=Tumblr
  description_default=View Tumblr blog
  prefix="https://<val>.tumblr.com/"
  media_type=3p
)

*class(
  ## TELEGRAM
  *id=tl
  *name=telegram
  *superclass=medium
  object_type=medium
  object_display_name=Telegram
  description_default=Connect with Telegram
  prefix="https://www.telegram.me/"
  media_type=3p
)

*class(
  ## TWITTER
  *id=tw
  *name=twitter
  *superclass=medium
  object_type=medium
  object_display_name=Twitter
  description_default=View Twitter profile
  prefix="https://www.twitter.com/"
  media_type=3p
  value_prefix=@
)

*class(
  ## TWOO
  *id=to
  *name=twoo
  *superclass=medium
  object_type=medium
  object_display_name=Twoo
  description_default=View Twoo page
  prefix="https://www.twoo.com/"
  media_type=3p
)

*class(
  ## VIBER
  *id=vb
  *name=viber
  *superclass=medium
  object_type=medium
  object_display_name=Viber
  description_default=Call with Viber
  prefix="https://www.viber.com/"
  media_type=3p
)

*class(
  ## VKONTAKTE
  *id=vk
  *name=vkontakte
  *superclass=medium
  object_type=medium
  object_display_name=Vkontakte
  description_default=View VK page
  prefix="https://www.vk.com/"
  media_type=3p
)

*class(
  ## VIMEO
  *id=vm
  *name=vimeo
  *superclass=medium
  object_type=medium
  object_display_name=Vimeo
  description_default=View Vimeo profile
  prefix="https://www.vimeo.com/"
  media_type=3p
)

*class(
  ## WHATSAPP
  *id=wa
  *name=whatsapp
  *superclass=medium
  object_type=medium
  object_display_name=Whatsapp
  description_default=Message on Whatsapp
  prefix="whatsapp://"
  media_type=3p
)

*class(
  ## WECHAT
  *id=wc
  *name=wechat
  *superclass=medium
  object_type=medium
  object_display_name=WeChat
  description_default=Connect with WeChat
  prefix="https://www.wechat.com/"
  media_type=3p
)

*class(
  ## XING
  *id=xi
  *name=xing
  *superclass=medium
  object_type=medium
  object_display_name=Xing
  description_default=View Xing page
  prefix="https://www.xing.com/"
  media_type=3p
)

*class(
  ## YOUTUBE
  *id=yt
  *name=youtube
  *superclass=medium
  object_type=medium
  object_display_name=YouTube
  description_default=View YouTube channel
  prefix="https://www.youtube.com/"
  media_type=3p
)

*class(
  ## YY
  *id=yy
  *name=yy
  *superclass=medium
  object_type=medium
  object_display_name=YY
  description_default=View YY page
  prefix="https://www.yy.com/"
  media_type=3p
)

*method(
  *id=rs
  *name=remove_spaces
  *transform=`replace( ,)`
)

*method(
  *id=rh
  *name=remove_hyphens
  *transform=`replace(-,)`
)

*method(
  *id=ru
  *name=remove_underscores
  *transform=`replace(_,)`
)

*method(
  *id=sh
  *name=replace_spaces_with_hyphens
  *transform=`replace( ,-)`
)

*method(
  *id=su
  *name=replace_spaces_with_underscores
  *transform=`replace( ,_)`
)

*method(
  *id=hs
  *name=replace_hyphens_with_spaces
  *transform=`replace(-, )`
)

*method(
  *id=hu
  *name=replace_hyphens_with_underscores
  *transform=`replace(-,_)`
)

*method(
  *id=us
  *name=replace_underscores_with_spaces
  *transform=`replace(_, )`
)

*method(
  *id=uh
  *name=replace_underscores_with_hyphens
  *transform=`replace(_,-)`
)

## These are predefined variables
_AC="Accounts"
_CS="Customer Service"
"""
}

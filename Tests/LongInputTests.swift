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

    func testLongInput() {
        self.measure {
            let modl = LongTest.modl
            let p = Interpreter()
            do {
                let result = try p.parseToJson(modl)
                print(result)
            } catch {
                XCTFail("Parse error: \(error.localizedDescription)")
            }
        }
    }
    
    func testConfigTest() {
        let modl = ConfigTest.modl
        let p = Interpreter()
        do {
            let result = try p.parseToJson(modl)
            let expected = MODLTestManager.processExpectedJSONResult(ConfigTest.expected)
            XCTAssert(result == expected)
        } catch {
            XCTFail("Parse error: \(error.localizedDescription)")
        }
    }
}


fileprivate struct ConfigTest {
    static let modl = """
            _C=gb;
            _L=en;
            _Q=numexample.com;
            _D=numexample.com;
            _DV=iPhone 7;
            _TZ=GMT;
            _GPS=53.473997,-2.237334;
            *load="https://s3.eu-west-2.amazonaws.com/modules.num.uk/1/rcf.txt";
            o=NUM Example Co:Example Strapline:[t=Call us:441270123456;fb=examplefacebook;tw=exampletwitter;in=exampleinstagram]
"""

    static let expected = """
{
    "organisation": {
        "name": "NUM Example Co",
        "slogan": "Example Strapline",
        "contacts": [
            {
                "telephone": {
                    "description": "Call us",
                    "value": "441270123456",
                    "object_type": "media",
                    "object_display_name": "Telephone",
                    "description_default": "Call",
                    "prefix": "tel://",
                    "media_type": "core"
                }
            },
            {
                "facebook": {
                    "value": "examplefacebook",
                    "object_type": "media",
                    "object_display_name": "Facebook",
                    "description_default": "View Facebook profile",
                    "prefix": "https://www.facebook.com/",
                    "media_type": "3p"
                }
            },
            {
                "twitter": {
                    "value": "exampletwitter",
                    "object_type": "media",
                    "object_display_name": "Twitter",
                    "description_default": "View Twitter profile",
                    "prefix": "https://www.twitter.com/",
                    "media_type": "3p",
                    "value_prefix": "@"
                }
            },
            {
                "instagram": {
                    "value": "exampleinstagram",
                    "object_type": "media",
                    "object_display_name": "Instagram",
                    "description_default": "View Instagram profile",
                    "prefix": "https://www.instagram.com/",
                    "media_type": "3p"
                }
            }
        ],
        "object_type": "entity",
        "object_display_name": "Organisation",
        "description_default": "View Organisation"
    }
}
"""
}

fileprivate struct LongTest {
    static let modl = """
{
!L?
_L=en
};
{
!C?
_C=gb
};

_locale_file = `%L`-`%C`;
{
locale_file=en-gb/en-us/es-es?
_locale_file_uri = "http://modules.num.uk/1/locales/`%locale_file`.txt"
/?
_locale_file_uri = "http://modules.num.uk/1/locales/en-us.txt"
};

*LOAD=%locale_file_uri;

## Only an entity or an array of entities can be at the root
## of a NUM MODL object.
*class(
*id=root;
*name=root;
*superclass=arr;
*expect=[entity]
);

## All maps that are allowed in NUM are an object of some kind
*class(
*id=object;
*name=object;
*superclass=map;
*expect=[i;h;q;c_;r_;tz]
);

## ENTITY: Someone or something to make contact with
*class(
*id=entity;
*name=entity;
*superclass=object;
*assign=[
[n];
[n;q]
##    [n;q;d]
##    [n;q;d;h;tz]
];
*expect=[n;c]
);

## MEDIUM: A way to make contact with an entity

*class(
*id=media;
*name=media;
*superclass=object;
*assign=[
## value, e.g. '441270123456'
[v];
## description and value, e.g. 'Sales:441270123456'
[d;v];
## description, value and available hours, e.g. 'Sales:441270123456:wd@9-17'
[d;v;h]
];
*expect=[v;ac]
);

*class(
## EXTENSION: A way to offer DNS/Web-based services, e.g. store locator
*id=x;
*name=extension;
*superclass=map;
*expect=[url;pa]
);

## ALL OBJECTS CAN BE DESCRIBED WITH THESE KEYS:
*class(
## INTRODUCTION: Introductory text for a NUM record
*id=i;
*name=introduction;
*superclass=str
);

*class(
## HOURS: The hours that an entity or medium is available
*id=h;
*name=hours;
*superclass=arr;
*expect=[str]
);

*class(
## TIME_ZONE_CITY: The default time zone city for an object
*id=tz;
*name=time_zone_city;
*superclass=str
);

*class(
## QUERY: Instructs the NUM client to make another query
*id=q;
*name=query;
*superclass=str
);

*class(
## CONTINUATION: The record continues at another DNS location
*id=c_;
*name=continuation_;
*superclass=str
);

*class(
## REDIRECT: The client should be redirected to a branch record
*id=r_;
*name=redirect_;
*superclass=str
);

*class(
## PERSON: A person to contact
*id=p;
*name=person;
*superclass=entity;
*expect=[b];
object_type=entity;
object_display_name=%locale.p.name;
description_default=%locale.p.default
);

*class(
## ORGANISATION: An organisation to make contact with
*id=o;
*name=organisation;
*superclass=entity;
*assign=[
## name, 'Tesco'
[n];
## name and objects 'Tesco:[t=44800 50 5555]'
[n;c];
## name, slogan and objects 'Tesco:Every Little Helps:[t=44800 50 5555]'
[n;s;c];
## object index, name, slogan and objects 'tesco:%1.s:Every Little Helps:[t=44800 50 5555;fb=%1]'
[?;n;s;c];
## ojbect index, name, slogan, available hours and objects 'tesco:%1.s:Every Little Helps:d@6-24:[t=44800 50 5555;fb=%1]'
[?;n;s;h;c]
];
*expect=[s];
object_type=entity;
object_display_name=%locale.o.name;
description_default=%locale.o.default
);

*class(
## DEPARTMENT: A department within an organisation
*id=dp;
*superclass=entity;
*name=department;
*expect=[d];
object_type=entity;
object_display_name=%locale.d.name;
description_default=%locale.d.default
);

*class(
## EMPLOYEE: An employee of an organisation to contact
*id=e;
*superclass=entity;
*name=employee;
## An employee object can be instantiated with keyless
## pairs by submitting values in this order:
## Name:Role, e.g:
## John Smith:Managing Director
*assign=[
## name, e.g. John Smith
[n];
## name and role, e.g. John Smith:Managing Director
[n;r]
];
*expect=[r];
object_type=entity;
object_display_name=%locale.e.name;
description_default=%locale.e.default
);

*class(
## LOCATION: e.g. a company store
*id=l;
*superclass=entity;
*name=location;
*expect=[d];
object_type=entity;
object_display_name=%locale.l.name;
description_default=%locale.l.default
);

*class(
## FOLDER: A folder containing more contact information
*id=f;
*superclass=entity;
*name=folder;
*expect=[d];
object_type=entity;
object_display_name=%locale.f.name;
description_default=%locale.f.default
);

## These keys are used for all entities
*class(
## ENTITY NAME: e.g. 'Tesco' or 'John Smith'
*id=n;
*name=name;
*superclass=str
);

*class(
## Contacts: A list of contacts
*id=c;
*name=contacts;
*superclass=arr;
*name=contacts;
*expect=[object]
);

## Biography is just for person
*class(
## BIOGRPAHY: Brief info about a person
*id=b;
*name=bio;
*superclass=str
);

## Slogan is just for organisations
*class(
## SLOGAN: The organisation slogan, e.g. 'Every Little Helps'
*id=s;
*name=slogan;
*superclass=str
);

## Description is for departments, locations and folders
*class(
## DESCRIPTION: A description of a medium, e.g 'Customer Service'
*id=d;
*name=description;
*superclass=str
);

## Role is just for employees
*class(
## ROLE: An employee's role at an organisation
*id=r;
*name=role;
*superclass=str
);

## These are just for media
*class(
## VALUE: A medium value, e.g. a telephone number
*id=v;
*name=value;
*superclass=str
);

*class(
## ACCESSIBILITY: Provides accessibility information for media
*id=ac;
*name=access;
*superclass=arr;
*expect=[str]
);

*class(
## TELEPHONE: A telephone number in E.164 (https://en.wikipedia.org/wiki/E.164) format
*id=t;
*name=telephone;
*superclass=media;
object_type=media;
object_display_name=%locale.t.name;
description_default=%locale.t.default;
prefix="tel://";
media_type=core
);

*class(
## SMS: An SMS number for enquiries in E.164 (https://en.wikipedia.org/wiki/E.164) format
*id=sm;
*name=sms;
*superclass=media;
object_type=media;
object_display_name=%locale.sm.name;
description_default=%locale.sm.default;
prefix="sms://";
media_type=core
);

*class(
## URL: The organisation's webpage or a webpage about a particular topic or product.
*id=u;
*name=url;
*superclass=media;
object_type=media;
object_display_name=%locale.u.name;
description_default=%locale.u.default;
prefix="https://";
media_type=core
);

*class(
## UNSECURE_URL: The organisation's webpage or a webpage about a particular topic or product.
*id=uu;
*name=unsecure_url;
*superclass=media;
object_type=media;
object_display_name=%locale.u.name;
description_default=%locale.u.default;
prefix="http://";
media_type=core
);

*class(
## GPS: GPS co-ordinates in WGS84 (https://en.wikipedia.org/wiki/World_Geodetic_System) format
## e.g. the location of a store or office. It's also possible to optionally show how a GPS location
## can be accessed (e.g. on foot / bicycle / wheelchair / car), for more information see accessibility
*id=g;
*name=gps;
*superclass=media;
object_type=media;
object_display_name=%locale.g.name;
description_default=%locale.g.default;
prefix=null;
media_type=core
);

*class(
## ADDRESS: A land / postal address.
*id=a;
*name=address;
*superclass=media;
object_type=media;
object_display_name=%locale.a.name;
description_default=%locale.a.default;
prefix=Based on user preferences set in client.;
media_type=core
);

*class(
## FAX: A number for fax transmission in E.164 (https://en.wikipedia.org/wiki/E.164) format
*id=fx;
*name=fax;
*superclass=media;
object_type=media;
object_display_name=%locale.fx.name;
description_default=%locale.fx.default;
prefix=Based on user preferences set in client.;
media_type=core
);

*class(
## EMAIL: An email address for enquiries. We do not recommend listing an email in the DNS.
*id=em;
*name=email;
*superclass=media;
object_type=media;
object_display_name=%locale.em.name;
description_default=%locale.em.default;
prefix="mailto://";
media_type=core
);

*class(
## ANDROID APP: A download link for an app on the Google Play store.
*id=aa;
*name=android-app;
*superclass=media;
object_type=media;
object_display_name=%locale.aa.name;
description_default=%locale.aa.default;
prefix="https://play.google.com/store/apps/details?id=";
media_type=3p
);

*class(
## IOS APP: A download link for an app on the Apple App Store.
*id=as;
*name=ios-app;
*superclass=media;
object_type=media;
object_display_name=%locale.as.name;
description_default=%locale.as.default;
prefix="https://itunes.apple.com/app/";
media_type=3p
);

*class(
## BAIDU TIEBA
*id=bt;
*name=baidu_tieba;
*superclass=media;
object_type=media;
object_display_name=%locale.bt.name;
description_default=%locale.bt.default;
prefix="https://tieba.baidu.com/";
media_type=3p
);

*class(
## FACEBOOK
*id=fb;
*name=facebook;
*superclass=media;
object_type=media;
object_display_name=%locale.fb.name;
description_default=%locale.fb.default;
prefix="https://www.facebook.com/";
media_type=3p
);

*class(
## FLIKR
*id=fk;
*name=flikr;
*superclass=media;
object_type=media;
object_display_name=%locale.fk.name;
description_default=%locale.fk.default;
prefix="https://www.flikr.com/";
media_type=3p
);

*class(
## FOURSQUARE
*id=fs;
*name=foursquare;
*superclass=media;
object_type=media;
object_display_name=%locale.fs.name;
description_default=%locale.fs.default;
prefix="https://www.foursquare.com/";
media_type=3p
);

*class(
## FACETIME
*id=ft;
*name=facetime;
*superclass=media;
object_type=media;
object_display_name=%locale.ft.name;
description_default=%locale.ft.default;
prefix="facetime://";
media_type=3p
);

*class(
## GOOGLE PLUS
*id=gp;
*name=google-plus;
*superclass=media;
object_type=media;
object_display_name=%locale.gp.name;
description_default=%locale.gp.default;
prefix="https://plus.google.com/";
media_type=3p;
value_prefix=+
);

*class(
## IMESSAGE
*id=im;
*name=imessage;
*superclass=media;
object_type=media;
object_display_name=%locale.im.name;
description_default=%locale.im.default;
prefix="imessage://";
media_type=3p
);

*class(
## INSTAGRAM
*id=in;
*name=instagram;
*superclass=media;
object_type=media;
object_display_name=%locale.in.name;
description_default=%locale.in.default;
prefix="https://www.instagram.com/";
media_type=3p
);

*class(
## KIK
*id=kk;
*name=kik;
*superclass=media;
object_type=media;
object_display_name=%locale.kk.name;
description_default=%locale.kk.default;
prefix="https://www.kik.com/u/";
media_type=3p
);

*class(
## LINKEDIN
*id=li;
*name=linkedin;
*superclass=media;
object_type=media;
object_display_name=%locale.li.name;
description_default=%locale.li.default;
prefix="https://www.linkedin.com/";
media_type=3p
);

*class(
## LINE
*id=ln;
*name=line;
*superclass=media;
object_type=media;
object_display_name=%locale.ln.name;
description_default=%locale.ln.default;
prefix="line://";
media_type=3p
);

*class(
## MEDIUM
*id=md;
*name=medium;
*superclass=media;
object_type=media;
object_display_name=%locale.md.name;
description_default=%locale.md.default;
prefix="https://www.medium.com/";
media_type=3p
);

*class(
## PERISCOPE
*id=pr;
*name=periscope;
*superclass=media;
object_type=media;
object_display_name=%locale.pr.name;
description_default=%locale.pr.default;
prefix="https://www.periscope.tv/";
media_type=3p/
);

*class(
## PINTEREST
*id=pi;
*name=pinterest;
*superclass=media;
object_type=media;
object_display_name=%locale.pi.name;
description_default=%locale.pi.default;
prefix="https://www.pinterest.com/";
media_type=3p
);

*class(
## QQ
*id=qq;
*name=qq;
*superclass=media;
object_type=media;
object_display_name=%locale.qq.name;
description_default=%locale.qq.default;
prefix="https://www.qq.com/";
media_type=3p
);

*class(
## QZONE
*id=qz;
*name=qzone;
*superclass=media;
object_type=media;
object_display_name=%locale.qz.name;
description_default=%locale.qz.default;
prefix="https://www.qzone.com/";
media_type=3p
);

*class(
## REDDIT
*id=rd;
*name=reddit;
*superclass=media;
object_type=media;
object_display_name=%locale.rd.name;
description_default=%locale.rd.default;
prefix="https://www.reddit.com/r/";
media_type=3p
);

*class(
## RENREN
*id=rn;
*name=renren;
*superclass=media;
object_type=media;
object_display_name=%locale.rn.name;
description_default=%locale.rn.default;
prefix="https://www.renren.com/";
media_type=3p
);

*class(
## SOUNDCLOUD
*id=sc;
*name=soundcloud;
*superclass=media;
object_type=media;
object_display_name=%locale.sc.name;
description_default=%locale.sc.default;
prefix="https://www.soundcloud.com/";
media_type=3p
);

*class(
## SKYPE
*id=sk;
*name=skype;
*superclass=media;
object_type=media;
object_display_name=%locale.sk.name;
description_default=%locale.sk.default;
prefix="skype://";
media_type=3p
);

*class(
## SWARM
*id=sr;
*name=swarm;
*superclass=media;
object_type=media;
object_display_name=%locale.sr.name;
description_default=%locale.sr.default;
prefix="https://www.swarmapp.com/";
media_type=3p
);

*class(
## SNAPCHAT
*id=sn;
*name=snapchat;
*superclass=media;
object_type=media;
object_display_name=%locale.sn.name;
description_default=%locale.sn.default;
prefix="snapchat://add/";
media_type=3p
);

*class(
## SINA WEIBO
*id=sw;
*name=sina-weibo;
*superclass=media;
object_type=media;
object_display_name=%locale.sw.name;
description_default=%locale.sw.default;
prefix="https://www.weibo.com/";
media_type=3p
);

*class(
## TUMBLR
*id=tb;
*name=tumblr;
*superclass=media;
object_type=media;
object_display_name=%locale.tb.name;
description_default=%locale.tb.default;
prefix="https://<val>.tumblr.com/";
media_type=3p
);

*class(
## TELEGRAM
*id=tl;
*name=telegram;
*superclass=media;
object_type=media;
object_display_name=%locale.tl.name;
description_default=%locale.tl.default;
prefix="https://www.telegram.me/";
media_type=3p
);

*class(
## TWITTER
*id=tw;
*name=twitter;
*superclass=media;
object_type=media;
object_display_name=%locale.tw.name;
description_default=%locale.tw.default;
prefix="https://www.twitter.com/";
media_type=3p;
value_prefix=@
);

*class(
## TWOO
*id=to;
*name=twoo;
*superclass=media;
object_type=media;
object_display_name=%locale.to.name;
description_default=%locale.to.default;
prefix="https://www.twoo.com/";
media_type=3p
);

*class(
## VIBER
*id=vb;
*name=viber;
*superclass=media;
object_type=media;
object_display_name=%locale.vb.name;
description_default=%locale.vb.default;
prefix="https://www.viber.com/";
media_type=3p
);

*class(
## VKONTAKTE
*id=vk;
*name=vkontakte;
*superclass=media;
object_type=media;
object_display_name=%locale.vk.name;
description_default=%locale.vk.default;
prefix="https://www.vk.com/";
media_type=3p
);

*class(
## VIMEO
*id=vm;
*name=vimeo;
*superclass=media;
object_type=media;
object_display_name=%locale.vm.name;
description_default=%locale.vm.default;
prefix="https://www.vimeo.com/";
media_type=3p
);

*class(
## WHATSAPP
*id=wa;
*name=whatsapp;
*superclass=media;
object_type=media;
object_display_name=%locale.wa.name;
description_default=%locale.wa.default;
prefix="whatsapp://";
media_type=3p
);

*class(
## WECHAT
*id=wc;
*name=wechat;
*superclass=media;
object_type=media;
object_display_name=%locale.wc.name;
description_default=%locale.wc.default;
prefix="https://www.wechat.com/";
media_type=3p
);

*class(
## XING
*id=xi;
*name=xing;
*superclass=media;
object_type=media;
object_display_name=%locale.xi.name;
description_default=%locale.xi.default;
prefix="https://www.xing.com/";
media_type=3p
);

*class(
## YOUTUBE
*id=yt;
*name=youtube;
*superclass=media;
object_type=media;
object_display_name=%locale.yt.name;
description_default=%locale.yt.default;
prefix="https://www.youtube.com/";
media_type=3p
);

*class(
## YY
*id=yy;
*name=yy;
*superclass=media;
object_type=media;
object_display_name=%locale.yy.name;
description_default=%locale.yy.default;
prefix="https://www.yy.com/";
media_type=3p
);

## DEFINE METHODS

*method(
*id=rs;
*name=remove_spaces;
*transform=`replace( ,)`
);

*method(
*id=rh;
*name=remove_hyphens;
*transform=`replace(-,)`
);

*method(
*id=ru;
*name=remove_underscores;
*transform=`replace(_,)`
);

*method(
*id=sh;
*name=replace_spaces_with_hyphens;
*transform=`replace( ,-)`
);

*method(
*id=su;
*name=replace_spaces_with_underscores;
*transform=`replace( ,_)`
);

*method(
*id=hs;
*name=replace_hyphens_with_spaces;
*transform=`replace(-, )`
);

*method(
*id=hu;
*name=replace_hyphens_with_underscores;
*transform=`replace(-,_)`
);

*method(
*id=us;
*name=replace_underscores_with_spaces;
*transform=`replace(_, )`
);

*method(
*id=uh;
*name=replace_underscores_with_hyphens;
*transform=`replace(_,-)`
);
"""}

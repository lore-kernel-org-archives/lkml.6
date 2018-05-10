Return-Path: <songjinshi@xiaomi.com>
X-Google-Smtp-Source: AB8JxZpI31/KkXZCaZ0mQEfoiXHH459GfatIxRYMKFEdFVJkM0qCu79osgHiYr3okIkVDC98LcgA
ARC-Seal: i=1; a=rsa-sha256; t=1525920084; cv=none;
        d=google.com; s=arc-20160816;
        b=muwxvm89LPdKnJ/PfAxvXlTL3XfsG2AsO+E1oIfrqDa24+Ji2adJ3OfwfZjfEYcGG5
         I4PUQAzBn3GAhPAtWSMgLixPt+Zu5NSiRmACeAyRnkzdmhDEsc8bv6FFAZzbEsCwayvD
         ebev/7nX5uykcRl6Mqgo7zLYH6yBtPF3+2cyUfCkxFc+Dd1RR0h0fWhredCW1+OPLhvU
         M4Huqjhinyl3rloC0WOxKWJuQRNJ84FM2ZAlOo4cSkDJoeVOFam0EUrXI5kw2flK4yIS
         SdGxaG1936qXL+fH5qT7ufsEQKIXsq/j3SokNCsaUC3JgWMHtB/G2y202nxL9KYr9NtW
         gKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:in-reply-to:references:message-id:date:thread-index
         :thread-topic:subject:cc:to:from:arc-authentication-results;
        bh=0H7G7uo0DQCasNL+KOpN3ErdooSUu3hASQ10JUjrjYQ=;
        b=UgtufG2vsLnyneIYoF3q7fodKUw+tbzfY+D23X349GntUH3ielK7VJesT7I28XoibQ
         BIZH54vSoPTD6ak75C0ANmiDlgMp+PQ8x5KcEfF+9H8R8Lva9S/m8Blz/LWM6dPNgmG9
         DHiecgQF4HctXcpSAF6f2aJYCNj2Qis4Uhz44Ub5Y5O/hzsAdXNoviOstFtPY0T0mw82
         yszkzIPqk6N8TGMSqaE5+LHrJyuCZtHqUzFLLvAFDXANfB6WQhSUSGu0F4deCQQUEF5X
         TbyQSmKkNi80uxxkxI7jDAcnNdSAHcffvfZAbH7gzIknhf8ox8BwJV2Go1uq5N7OxOnk
         zstQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.123 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of songjinshi@xiaomi.com designates 207.226.244.123 as permitted sender) smtp.mailfrom=songjinshi@xiaomi.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=xiaomi.com
From: =?utf-8?B?5a6L6YeR5pe2?= <songjinshi@xiaomi.com>
To: Todd Kjos <tkjos@google.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Martijn Coenen
	<maco@android.com>, =?utf-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIEFORFJPSUQ6IGJpbmRlcjogY29ycmVjdCB0aGUg?=
 =?utf-8?B?Y21kIHByaW50IGZvciBCSU5ERVJfV09SS19SRVRVUk5fRVJST1I=?=
Thread-Topic: [PATCH] ANDROID: binder: correct the cmd print for
 BINDER_WORK_RETURN_ERROR
Thread-Index: AQHT52b+yfI34teHBEqLYMBM+7MiaKQnLJUAgAETkHw=
Date: Thu, 10 May 2018 02:41:21 +0000
Message-ID: <1525920081130.81742@xiaomi.com>
References: <1525851089096.52313@xiaomi.com>,<CAHRSSEwjH=GyxR7E0WhpDb9so_Lc=3-M=2-zmYhptViX5=ZSTg@mail.gmail.com>
In-Reply-To: <CAHRSSEwjH=GyxR7E0WhpDb9so_Lc=3-M=2-zmYhptViX5=ZSTg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.10.121]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599970857323840855?=
X-GMAIL-MSGID: =?utf-8?q?1600043178828356668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

T0vvvIx0aGlzIHBhdGNoIGlzIGJhc2VkIG9uIHRoZSBkb3duc3RyZWFtIGFuZHJvaWQga2VybmVs
NC40IHZlcnNpb24sIG5vdCB5ZXQgaW5jbHVkZSB0aGUgbGF0ZXN0IGNoYW5nZXMsIGxldCBtZSB1
cGRhdGUgdGhlIHBhdGNoIHRvIGJhc2Ugb24gdGhlIGxhdGVzdCB1cHN0cmVhbSwgVGtzLgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwrlj5Hku7bkuro6IFRvZGQgS2pv
cyA8dGtqb3NAZ29vZ2xlLmNvbT4K5Y+R6YCB5pe26Ze0OiAyMDE45bm0NeaciDEw5pelIDI6MDgK
5pS25Lu25Lq6OiDlrovph5Hml7YK5oqE6YCBOiBHcmVnIEtyb2FoLUhhcnRtYW47IE1hcnRpam4g
Q29lbmVuOyBBcnZlIEhqw7hubmV2w6VnOyBMS01MCuS4u+mimDogUmU6IFtQQVRDSF0gQU5EUk9J
RDogYmluZGVyOiBjb3JyZWN0IHRoZSBjbWQgcHJpbnQgZm9yIEJJTkRFUl9XT1JLX1JFVFVSTl9F
UlJPUgoKT24gV2VkLCBNYXkgOSwgMjAxOCBhdCAxMjozMSBBTSDlrovph5Hml7YgPHNvbmdqaW5z
aGlAeGlhb21pLmNvbT4gd3JvdGU6Cgo+IEluIGNhc2Ugb2YgdGhlIEJJTkRFUl9XT1JLX1JFVFVS
Tl9FUlJPUiB0aGUgY21kIGlzIG5vIGFzc2lnbm1lbnQsCj4gc28gaXQncyB2YWx1ZSB3aWxsIGJl
IG9sZCB2YWx1ZSBvciBkaXJ0eSB2YWx1ZSwgYmVmb3JlIG1vZGlmeWluZwo+IGUtPmNtZCwgYXNz
aWduIHRoZSB2YWx1ZSBvZiB0aGUgZS0+Y21kIHRvIGNtZCB0byBlbnN1cmUgdGhlIGNvcnJlY3QK
PiBwcmludCBvZiBiaW5kZXJfc3RhdF9ici4KCgpUaGF0J3Mgbm90IHRoZSBwcm9ibGVtLi4uIHRo
ZSBwcm9ibGVtIGlzIHRoYXQgZS0+Y21kIGlzIHVuY29uZGl0aW9uYWxseSBzZXQKdG8gQlJfT0sg
cHJpb3IgdG8gdGhlIGNhbGwgdG8gYmluZGVyX3N0YXRfYnIocHJvYywgdGhyZWFkLCBlLT5jbWQp
IHNvIHRoZQpyZXBvcnRlZCBjbWQgaXMgYWx3YXlzIEJSX09LLgoKCj4gU2lnbmVkLW9mZi1ieTog
c29uZ2ppbnNoaSA8c29uZ2ppbnNoaUB4aWFvbWkuY29tPgo+IC0tLQoKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCj4gaW5k
ZXggNGZmYzg0ZC4uYWNkN2Q0NGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9hbmRyb2lkL2JpbmRl
ci5jCj4gKysrIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCj4gQEAgLTQwODYsNiArNDA4Niw3
IEBACj4gICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBiaW5kZXJfZXJyb3IgKmUgPSBj
b250YWluZXJfb2YoCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3
LCBzdHJ1Y3QgYmluZGVyX2Vycm9yLCB3b3JrKTsKCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
Y21kID0gZS0+Y21kOwo+ICAgICAgICAgICAgICAgICAgICAgICAgICBXQVJOX09OKGUtPmNtZCA9
PSBCUl9PSyk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgIGJpbmRlcl9pbm5lcl9wcm9jX3Vu
bG9jayhwcm9jKTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHB1dF91c2VyKGUtPmNt
ZCwgKHVpbnQzMl90IF9fdXNlciAqKXB0cikpCgoKRG9uJ3QgeW91IGFsc28gbmVlZCB0byB1c2Ug
Y21kIGluIHRoZSBjYWxsIHRvIGJpbmRlcl9zdGF0ZV9icigpIGJlbG93PwoKLSAgICAgICAgICAg
ICAgICAgICAgICAgYmluZGVyX3N0YXRfYnIocHJvYywgdGhyZWFkLCBlLT5jbWQpOworICAgICAg
ICAgICAgICAgICAgICAgICBiaW5kZXJfc3RhdF9icihwcm9jLCB0aHJlYWQsIGNtZCk7CgotVG9k
ZAo=

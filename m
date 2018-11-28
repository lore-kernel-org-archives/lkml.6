Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C8CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE752081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE752081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeK2AUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:20:25 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22883 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727726AbeK2AUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:20:25 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-68-XVoaacNlPN6nBxXzp5jJXg-1; Wed, 28 Nov 2018 13:18:44 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 28 Nov 2018 13:18:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 28 Nov 2018 13:18:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'David Newall' <glibc@davidnewall.com>,
        Florian Weimer <fweimer@redhat.com>,
        Daniel Colascione <dancol@google.com>
CC:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        Carlos O'Donell <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Subject: RE: Official Linux system wrapper library?
Thread-Topic: Official Linux system wrapper library?
Thread-Index: AQHUgzcs2na6waCpDUiFsbnFx9Uqv6VlMozA
Date:   Wed, 28 Nov 2018 13:18:53 +0000
Message-ID: <3e5914fce1534c698114bdf171c16c5d@AcuMS.aculab.com>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
 <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com>
 <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <87efbbvrx9.fsf@oldenburg.str.redhat.com>
 <a50dbc52-b5e8-6684-508d-b96ad8d70d4f@davidnewall.com>
In-Reply-To: <a50dbc52-b5e8-6684-508d-b96ad8d70d4f@davidnewall.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: XVoaacNlPN6nBxXzp5jJXg-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgTmV3YWxsDQo+IFNlbnQ6IDIzIE5vdmVtYmVyIDIwMTggMTQ6MTENCj4gDQo+
IE9uIDI0LzExLzE4IDEyOjA0IGFtLCBGbG9yaWFuIFdlaW1lciB3cm90ZToNCj4gPiBCdXQgc29j
a2V0Y2FsbCBkb2VzIG5vdCBleGlzdCBvbiBhbGwgYXJjaGl0ZWN0dXJlcy4gIE5laXRoZXIgZG9l
cw0KPiA+IGdldHBpZCwgaXQncyBjYWxsZWQgZ2V0eHBpZCBvbiBzb21lIGFyY2hpdGVjdHVyZXMu
DQo+ID4gLi4uDQo+ID4gSSB0aGluayBpdCB3b3VsZCBiZSBhIHBvb3IgYXBwcm9hY2ggdG8gZXhw
b3NlIGFwcGxpY2F0aW9uIGRldmVsb3BlcnMgdG8NCj4gPiB0aGVzZSBwb3J0YWJpbGl0eSBpc3N1
ZXMuICBXZSBuZWVkIHRvIGFic3RyYWN0IG92ZXIgdGhlc2UgZGlmZmVyZW5jZXMgYXQNCj4gPiBh
IGNlcnRhaW4gbGF5ZXIsIGFuZCBhcHBsaWNhdGlvbnMgYXJlIHRvbyBsYXRlLg0KPiANCj4gSW50
ZXJlc3RpbmcuwqAgSSB0aGluayB0aGUgb3Bwb3NpdGUuwqAgSSB0aGluayBleHBvc2luZyB0aGUg
T1Mncw0KPiBpbnRlcmZhY2VzIGlzIGV4YWN0bHkgd2hhdCBhIGMtbGlicmFyeSBzaG91bGQgZG8u
wqAgSXQgbWlnaHQgYWxzbyBwcm92aWRlDQo+IGFsdGVybmF0aXZlIGludGVyZmFjZXMgdGhhdCB3
b3JrIGNvbnNpc3RlbnRseSBhY3Jvc3MgZGlmZmVyZW50DQo+IHBsYXRmb3JtcywgYnV0IGluIGFk
ZGl0aW9uIHRvLCBub3QgaW5zdGVhZCBvZiB0aGUgT1MgaW50ZXJmYWNlLg0KDQpBbHNvLCBpdCBy
ZWFsbHkgc2hvdWxkbid0IGltcGxlbWVudCBicm9rZW4gd29ya2Fyb3VuZHMgZm9yICdtaXNzaW5n
Jw0Kc3lzdGVtIGNhbGxzLg0KQXQgbGVhc3Qgb25lIEMgbGlicmFyeSBJJ3ZlIG1ldCBjb252ZXJ0
ZWQgcHJlYWQoKSBpbnRvIGxzZWVrKCkgYW5kIHJlYWQoKS4NClRoYXQgaXMganVzdCBzbyBicm9r
ZW4gaXQgaXMgYmV0dGVyIHRvIGZhaWwgdG8gbGluayBvciBmYWlsIGF0IHJ1bnRpbWUuDQoNCk5l
dmVyIG1pbmQgYWxsIHRoZSBmdW4gdHJ5aW5nIHRvIHJlYWQgQ0xPQ0tfTU9OT1RPTklDLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


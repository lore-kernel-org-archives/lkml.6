Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ABF206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbeLNOir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:38:47 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:28308 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726554AbeLNOir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:38:47 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-109-Ck1L3wHcP-6yXgXKCEeFmw-1; Fri, 14 Dec 2018 14:38:42 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 14 Dec 2018 14:38:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 14 Dec 2018 14:38:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Richard Weinberger' <richard.weinberger@gmail.com>,
        "kevin@guarana.org" <kevin@guarana.org>
CC:     "glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "x32@buildd.debian.org" <x32@buildd.debian.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: RE: Can we drop upstream Linux x32 support?
Thread-Topic: Can we drop upstream Linux x32 support?
Thread-Index: AQHUksMIEw1uarZA0kyk7mn2rjoPwKV+S2TA
Date:   Fri, 14 Dec 2018 14:38:53 +0000
Message-ID: <d54d7ea7c558474583dfed0d26f05ccd@AcuMS.aculab.com>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <70bb54b2-8ed3-b5ee-c02d-6ef66c4f27eb@physik.fu-berlin.de>
 <20181213050313.GA21201@ip-172-31-15-78>
 <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
In-Reply-To: <CAFLxGvy2sMW1nyMpxGN7xHPdUea713g89MdE3EcUNHJDCvZ3jA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Ck1L3wHcP-6yXgXKCEeFmw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmljaGFyZCBXZWluYmVyZ2VyDQo+IFNlbnQ6IDEzIERlY2VtYmVyIDIwMTggMDk6MDUN
Cj4gT24gVGh1LCBEZWMgMTMsIDIwMTggYXQgNjowMyBBTSBLZXZpbiBFYXN0b24gPGtldmluQGd1
YXJhbmEub3JnPiB3cm90ZToNCj4gPg0KPiA+IE9uIFR1ZSwgRGVjIDExLCAyMDE4IGF0IDExOjI5
OjE0QU0gKzAxMDAsIEpvaG4gUGF1bCBBZHJpYW4gR2xhdWJpdHogd3JvdGU6DQo+ID4gLi4uDQo+
ID4gPiBJIGNhbid0IHNheSBhbnl0aGluZyBhYm91dCB0aGUgc3lzY2FsbCBpbnRlcmZhY2UuIEhv
d2V2ZXIsIHdoYXQgSSBkbyBrbm93DQo+ID4gPiBpcyB0aGF0IHRoZSB3ZWlyZCBjb21iaW5hdGlv
biBvZiBhIDMyLWJpdCB1c2VybGFuZCB3aXRoIGEgNjQtYml0IGtlcm5lbA0KPiA+ID4gaW50ZXJm
YWNlIGlzIHNvbWV0aW1lcyBjYXVzaW5nIGlzc3Vlcy4gRm9yIGV4YW1wbGUsIGFwcGxpY2F0aW9u
IGNvZGUgdXN1YWxseQ0KPiA+ID4gZXhwZWN0cyB0aGluZ3MgbGlrZSB0aW1lX3QgdG8gYmUgMzIt
Yml0IG9uIGEgMzItYml0IHN5c3RlbS4gSG93ZXZlciwgdGhpcw0KPiA+ID4gaXNuJ3QgdGhlIGNh
c2UgZm9yIHgzMiB3aGljaCBpcyB3aHkgY29kZSBmYWlscyB0byBidWlsZC4NCj4gPg0KPiA+IE9w
ZW5CU0QgYW5kIE5ldEJTRCBib3RoIGhhdmUgNjQtYml0IHRpbWVfdCBvbiAzMi1iaXQgc3lzdGVt
cyBhbmQgaGF2ZQ0KPiA+IGhhZCBmb3IgZm91ciBvciBmaXZlIHllYXJzIGF0IHRoaXMgcG9pbnQu
DQo+IA0KPiBUaGV5IGNhbiBhbHNvIGRvIGZsYWctZGF5IGNoYW5nZXMgYW5kIGJyZWFrIGV4aXN0
aW5nIGFwcGxpY2F0aW9ucywgTGludXggbm90Lg0KDQpOb3QgdHJ1ZSBhdCBhbGwuDQpUaGUgYmlu
YXJ5IGNvbXBhdGliaWxpdHkgaW4gTmV0QlNEIGlzIHByb2JhYmx5IGJldHRlciB0aGFuIHRoYXQg
aW4gTGludXgNCmFuZCBnb2VzIGJhY2sgYSBsb25nIHdheS4NCg0KRm9yIHRoZSB0aW1lX3QgY2hh
bmdlcyBuZXcgc3lzdGVtIGNhbGxzIG51bWJlcnMgd2VyZSBhc3NpZ25lZCB3aGVyZSBuZWVkZWQu
DQpUaGUgc3lzdGVtIGhlYWRlcnMgYW5kIGxpYmMgd2VyZSB1cGRhdGVkIHNvIHRoYXQgcmVjb21w
aWxlZCBjb2RlIHdvdWxkDQp1c2UgdGhlIG5ldyBzeXN0ZW0gY2FsbHMuDQoNClRoZSBvbmx5IHJl
YWwgYWR2YW50YWdlIHRoYXQgTmV0QlNEIGhhcyBpcyB0aGF0IGl0cyBsaWJjIChhbmQgc3RhbmRh
cmQNCnV0aWxpdGllcykgYXJlIHJlbGVhc2VkIHdpdGggdGhlIGtlcm5lbCBtYWtpbmcgaXQgbXVj
aCBlYXNpZXIgdG8gZ2V0DQphcHBsaWNhdGlvbnMgdG8gdXNlIHRoZSBuZXcgZmVhdHVyZXMuDQoN
ClRoaXMgd2FzIGFsc28gZG9uZSBhIHZlcnkgbG9uZyB0aW1lIGFnbyB3aGVuIGZpbGUgb2Zmc2V0
cyB3ZXJlIGV4dGVuZGVkDQp0byA2NCBiaXRzLg0KDQpTb21lIG9mIHRoZSBzeXN0ZW0gY2FsbHMg
aGF2ZSBxdWl0ZSBhIGZldyAnY29tcGF0aWJpbGl0eScgdmVyc2lvbnMuDQpBcyB3ZWxsIGFzIHRo
ZSBvbmVzIGZvciBlbXVsYXRpb25zIG9mIG90aGVyIG9wZXJhdGluZyBzeXN0ZW1zLg0KSXQgaGFz
IGJlZW4gcG9zc2libGUgdG8gcnVuIGNvcGllcyBvZiBmaXJlZm94IGNvbXBpbGVkIGZvciBMaW51
eA0KdW5kZXIgTmV0QlNELg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11AFECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B538B205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:25:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B538B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbeJaXXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:23:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:22583 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729494AbeJaXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:23:37 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by dkim.mimecast.com with ESMTP id
 uk-mta-169-yJgCRg4gN6OzIim__iclww-1; Wed, 31 Oct 2018 14:25:18 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 31 Oct 2018 14:25:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 31 Oct 2018 14:25:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Colascione' <dancol@google.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "timmurray@google.com" <timmurray@google.com>,
        "joelaf@google.com" <joelaf@google.com>
Subject: RE: [RFC PATCH] Minimal non-child process exit notification support
Thread-Topic: [RFC PATCH] Minimal non-child process exit notification support
Thread-Index: AQHUb7BQVhTcKn4SykenXuciwsVIoKU5SOFwgAAJ8QCAABLgAA==
Date:   Wed, 31 Oct 2018 14:25:22 +0000
Message-ID: <4ed9af67cf4a46708905d3f392344bcb@AcuMS.aculab.com>
References: <20181029175322.189042-1-dancol@google.com>
 <4beaaae77bea4cc5b4cc15504331c9a9@AcuMS.aculab.com>
 <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com>
In-Reply-To: <CAKOZuetR6_ztfJOe4TMVCX2J5sfuP8XBtG66hmsDkx-KH=CpJw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: yJgCRg4gN6OzIim__iclww-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGFuaWVsIENvbGFzY2lvbmUNCj4gU2VudDogMzEgT2N0b2JlciAyMDE4IDEyOjU2DQo+
IE9uIFdlZCwgT2N0IDMxLCAyMDE4IGF0IDEyOjI3IFBNLCBEYXZpZCBMYWlnaHQgPERhdmlkLkxh
aWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPiBGcm9tOiBEYW5pZWwgQ29sYXNjaW9uZQ0KPiA+
PiBTZW50OiAyOSBPY3RvYmVyIDIwMTggMTc6NTMNCj4gPj4NCj4gPj4gVGhpcyBwYXRjaCBhZGRz
IGEgbmV3IGZpbGUgdW5kZXIgL3Byb2MvcGlkLCAvcHJvYy9waWQvZXhpdGhhbmQuDQo+ID4+IEF0
dGVtcHRpbmcgdG8gcmVhZCBmcm9tIGFuIGV4aXRoYW5kIGZpbGUgd2lsbCBibG9jayB1bnRpbCB0
aGUNCj4gPj4gY29ycmVzcG9uZGluZyBwcm9jZXNzIGV4aXRzLCBhdCB3aGljaCBwb2ludCB0aGUg
cmVhZCB3aWxsIHN1Y2Nlc3NmdWxseQ0KPiA+PiBjb21wbGV0ZSB3aXRoIEVPRi4gIFRoZSBmaWxl
IGRlc2NyaXB0b3Igc3VwcG9ydHMgYm90aCBibG9ja2luZw0KPiA+PiBvcGVyYXRpb25zIGFuZCBw
b2xsKDIpLiBJdCdzIGludGVuZGVkIHRvIGJlIGEgbWluaW1hbCBpbnRlcmZhY2UgZm9yDQo+ID4+
IGFsbG93aW5nIGEgcHJvZ3JhbSB0byB3YWl0IGZvciB0aGUgZXhpdCBvZiBhIHByb2Nlc3MgdGhh
dCBpcyBub3Qgb25lDQo+ID4+IG9mIGl0cyBjaGlsZHJlbi4NCj4gPg0KPiA+IFdoeSBkbyB5b3Ug
bmVlZCBhbiBleHRyYSBmaWxlPw0KPiANCj4gQmVjYXVzZSBubyBjdXJyZW50IGZpbGUgc3VmZmlj
ZXMuDQoNClRoYXQgZG9lc24ndCBzdG9wIHlvdSBtYWtpbmcgc29tZXRoaW5nIHdvcmsgb24gYW55
L2FsbCBvZiB0aGUgZXhpc3RpbmcgZmlsZXMuDQoNCj4gPiBJdCBvdWdodCB0byBiZSBwb3NzaWJs
ZSB0byB1c2UgcG9sbCgpIHRvIHdhaXQgZm9yIFBPTExFUlIgaGF2aW5nIHNldA0KPiA+ICdldmVu
dHMnIHRvIHplcm8gb24gYW55IG9mIHRoZSBub2RlcyBpbiAvcHJvYy9waWQgLSBvciBldmVuIG9u
DQo+ID4gdGhlIGRpcmVjdG9yeSBpdHNlbGYuDQo+IA0KPiBUaGF0IGRvZXNuJ3QgYWN0dWFsbHkg
d29yayB0b2RheS4gQW5kIHdhaXRpbmcgb24gYSBkaXJlY3Rvcnkgd2l0aA0KPiBQT0xMRVJSIHdv
dWxkIGJlIHZlcnkgd2VpcmQsIHNpbmNlIGRpcmVjdG9yaWVzIGluIGdlbmVyYWwgZG9uJ3QgZG8N
Cj4gdGhpbmdzIGxpa2UgYmxvY2tpbmcgcmVhZHMgb3IgcG9sbCBzdXBwb3J0LiBBIHNlcGFyYXRl
IGZpbGUgd2l0aA0KPiBzZWxmLWNvbnRhaW5lZCwgd2VsbC1kZWZpbmVkIHNlbWFudGljcyBpcyBj
bGVhbmVyLg0KDQpEZXZpY2UgZHJpdmVycyB3aWxsICh3ZWxsIG91Z2h0IHRvKSByZXR1cm4gUE9M
TEVSUiB3aGVuIGEgZGV2aWNlDQppcyByZW1vdmVkLg0KTWFraW5nIHByb2NmcyBiZWhhdmUgdGhl
IHNhbWUgd2F5IHdvdWxkbid0IGJlIHRvbyBzdHVwaWQuDQoNCj4gPiBJbmRlZWQsIHRvIGF2b2lk
IGtpbGxpbmcgdGhlIHdyb25nIHByb2Nlc3MgeW91IG5lZWQgdG8gaGF2ZSBvcGVuZWQNCj4gPiBz
b21lIG5vZGUgb2YgL3Byb2MvcGlkLyogKG1heWJlIGNtZGxpbmUpIGJlZm9yZSBzZW5kaW5nIHRo
ZSBraWxsDQo+ID4gc2lnbmFsLg0KPiANCj4gVGhlIGtlcm5lbCByZWFsbHkgbmVlZHMgYmV0dGVy
IGRvY3VtZW50YXRpb24gb2YgdGhlIHNlbWFudGljcyBvZg0KPiBwcm9jZnMgZmlsZSBkZXNjcmlw
dG9ycy4gWW91J3JlIG5vdCB0aGUgb25seSBwZXJzb24gdG8gdGhpbmssDQo+IG1pc3Rha2VubHks
IHRoYXQga2VlcGluZyBhIHJlZmVyZW5jZSB0byBhIC9wcm9jLyRQSUQvc29tZXRoaW5nIEZEDQo+
IHJlc2VydmVzICRQSUQgYW5kIHByZXZlbnRzIGl0IGJlaW5nIHVzZWQgZm9yIGFub3RoZXIgcHJv
Y2Vzcy4gUHJvY2ZzDQo+IEZEcyBkbyBubyBzdWNoIHRoaW5nLiBraWxsKDIpIGlzIHVuc2FmZSB3
aGV0aGVyIG9yIG5vdA0KPiAvcHJvYy9waWQvY21kbGluZSBvciBhbnkgb3RoZXIgL3Byb2MgZmls
ZSBpcyBvcGVuLg0KDQpJbnRlcmVzdGluZy4NCkxpbnV4ICdmaXhlZCcgdGhlIHByb2JsZW0gb2Yg
cGlkIHJldXNlIGluIHRoZSBrZXJuZWwgYnkgYWRkaW5nIChJSVJDKQ0KJ3N0cnVjdCBwaWQnIHRo
YXQgcmVmZXJlbmNlIGNvdW50cyB0aGUgcGlkIHN0b3BwaW5nIHJldXNlLg0KQnV0IHNpbmNlIHRo
ZSBwaWRzIGFyZSBzdGlsbCBhbGxvY2F0ZWQgc2VxdWVudGlhbGx5IHVzZXJzcGFjZSBjYW4NCnN0
aWxsIHJlZmVyZW5jZSBhIHBpZCB0aGF0IGlzIGZyZWVkIGFuZCBpbW1lZGlhdGVseSByZXVzZWQu
DQpJJ2QgaGF2ZSB0aG91Z2h0IHRoYXQgcHJvY2ZzIG5vZGVzIGhlbGQgYSByZWZlcmVuY2UgY291
bnQgb24gdGhlICdzdHJ1Y3QgcGlkJy4NClRoZXJlJ3MgcHJvYmFibHkgbm8gcmVhc29uIHdoeSBp
dCBzaG91bGRuJ3QuDQoNCkFubm95aW5nbHkgbm9uLUdQTCBkcml2ZXJzIGNhbid0IHJlbGVhc2Ug
cmVmZXJlbmNlcyB0byAnc3RydWN0IHBpZCcgc28NCmFyZSB2ZXJ5IGNvbnN0cmFpbmVkIGFib3V0
IHdoaWNoIHByb2Nlc3NlcyB0aGV5IGNhbiBzaWduYWwuDQpJIGFsc28gbWFuYWdlZCB0byB1c2Ug
YSBzdGFsZSAnc3RydWN0IHBpZCcgYW5kIGtpbGwgdGhlIHdyb25nIHByb2Nlc3MNCi0gbXVjaCBt
b3JlIGxpa2VseSB0aGF0IHRoZSBwaWQgbnVtYmVyIGJlaW5nIHJldXNlZC4NCg0KSWYgeW91IGxv
b2sgYXQgdGhlIE5ldEJTRCBwaWQgYWxsb2NhdG9yIHlvdSdsbCBzZWUgdGhhdCBpdCB1c2VzIHRo
ZQ0KbG93IHBpZCBiaXRzIHRvIGluZGV4IGFuIGFycmF5IGFuZCB0aGUgaGlnaCBiaXRzIGFzIGEg
c2VxdWVuY2UgbnVtYmVyLg0KVGhlIGFycmF5IHNsb3RzIGFyZSBhbHNvIHJldXNlZCBMSUZPLCBz
byB5b3UgYWx3YXlzIG5lZWQgYSBzaWduaWZpY2FudA0KbnVtYmVyIG9mIHBpZCBhbGxvY2F0ZS9m
cmVlIGJlZm9yZSBhIG51bWJlciBpcyByZXVzZWQuDQpUaGUgbm9uLXNlcXVlbnRpYWwgYWxsb2Nh
dGlvbiBhbHNvIG1ha2VzIGl0IHNpZ25pZmljYW50bHkgbW9yZSBkaWZmaWN1bHQNCnRvIHByZWRp
Y3Qgd2hlbiBhIHBpZCB3aWxsIGJlIHJldXNlZC4NClRoZSB0YWJsZSBzaXplIGlzIGRvdWJsZWQg
d2hlbiBpdCBnZXRzIG5lYXJseSBmdWxsLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


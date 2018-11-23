Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B392C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D072205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 15:44:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D072205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440338AbeKXC3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 21:29:09 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20681 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391033AbeKXC3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 21:29:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-75-DYrajIG0P3uwNsBz6oQmYA-1; Fri, 23 Nov 2018 15:44:22 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 23 Nov 2018 15:44:29 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 23 Nov 2018 15:44:29 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Voegtle' <tv@lio96.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "patches@kernelci.org" <patches@kernelci.org>,
        "ben.hutchings@codethink.co.uk" <ben.hutchings@codethink.co.uk>,
        "lkft-triage@lists.linaro.org" <lkft-triage@lists.linaro.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH 4.19 00/42] 4.19.4-stable review
Thread-Topic: [PATCH 4.19 00/42] 4.19.4-stable review
Thread-Index: AQHUg0LyDymwbLE4eUi+UInvKHEL7aVdgA4w
Date:   Fri, 23 Nov 2018 15:44:29 +0000
Message-ID: <80f8817e9629410fb73354d611dcd756@AcuMS.aculab.com>
References: <20181121183147.869199006@linuxfoundation.org>
 <alpine.LSU.2.21.1811222148260.12239@er-systems.de>
 <20181123065143.GC23835@kroah.com>
 <alpine.LSU.2.21.1811231636220.17615@er-systems.de>
In-Reply-To: <alpine.LSU.2.21.1811231636220.17615@er-systems.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DYrajIG0P3uwNsBz6oQmYA-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogVGhvbWFzIFZvZWd0bGUNCj4gU2VudDogMjMgTm92ZW1iZXIgMjAxOCAxNTo0MQ0KPiBP
biBGcmksIDIzIE5vdiAyMDE4LCBHcmVnIEtyb2FoLUhhcnRtYW4gd3JvdGU6DQo+IA0KPiA+IE9u
IFRodSwgTm92IDIyLCAyMDE4IGF0IDA5OjUzOjM1UE0gKzAxMDAsIFRob21hcyBWb2VndGxlIHdy
b3RlOg0KPiA+Pg0KPiA+PiBEb2Vzbid0IGNvbXBpbGUgZm9yIG1lIG9uIE9wZW5TdVNFIDE1LjAg
KGdjYyA3LjMuMSk6DQo+ID4+DQo+ID4+ICAgQ0FMTCAgICBzY3JpcHRzL2NoZWNrc3lzY2FsbHMu
c2gNCj4gPj4gICBERVNDRU5EICBvYmp0b29sDQo+ID4+ICAgQ0hLICAgICBpbmNsdWRlL2dlbmVy
YXRlZC9jb21waWxlLmgNCj4gPj4gICBDQyBbTV0gIGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVf
Z2VtX2d0dC5vDQo+ID4+IGRyaXZlcnMvZ3B1L2RybS9pOTE1L2k5MTVfZ2VtX2d0dC5jOiBJbiBm
dW5jdGlvbiDigJhnZW42X2R1bXBfcHBndHTigJk6DQo+ID4+IGRyaXZlcnMvZ3B1L2RybS9pOTE1
L2k5MTVfZ2VtX2d0dC5jOjE3NzE6NDE6IGVycm9yOiBmb3JtYXQg4oCYJWxseOKAmSBleHBlY3Rz
DQo+ID4+IGFyZ3VtZW50IG9mIHR5cGUg4oCYbG9uZyBsb25nIHVuc2lnbmVkIGludOKAmSwgYnV0
IGFyZ3VtZW50IDUgaGFzIHR5cGUg4oCYbG9uZw0KPiA+PiB1bnNpZ25lZCBpbnTigJkgWy1XZXJy
b3I9Zm9ybWF0PV0NCj4gPj4gICAgIHNlcV9wcmludGYobSwgIlx0XHQoJTAzZCwgJTA0ZCkgJTA4
bGx4OiAiLA0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fn5+fl4N
Cj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJTA4bHgNCj4gPj4gY2Mx
OiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gPg0KPiA+IFdhcm5pbmdz
IHRyZWF0ZWQgYXMgZXJyb3JzPyAgVGhhdCdzIHJvdWdoLCBzb3JyeSwgZG9uJ3QgZG8gdGhhdCA6
KQ0KPiANCj4gSSBoYWQgQ09ORklHX0RSTV9JOTE1X1dFUlJPUj15IGZvciB3aGF0ZXZlciByZWFz
b24uDQo+IFRoZSB3aG9sZSB0aGluZyBjb25mdXNlZCBtZSBhIGxvdC4NCj4gU29ycnkuDQoNCldl
bGwsIGlmIHlvdSBjb21waWxlIHRoYXQgY29kZSBmb3IgYSAzMmJpdCBhcmNoaXRlY3R1cmUgaXQg
aXMgbGlrZWx5DQp0byBwcmludCBnYXJiYWdlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


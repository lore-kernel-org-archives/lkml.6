Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A8EC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631DC21A18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 16:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631DC21A18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbeHFSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 14:49:34 -0400
Received: from eu-smtp-delivery-211.mimecast.com ([146.101.78.211]:24752 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbeHFSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 14:49:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by eu-smtp-1.mimecast.com with ESMTP id
 uk-mta-69-BWwyAWdDOHi05sizLNub4g-1; Mon, 06 Aug 2018 17:39:38 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 6 Aug 2018 17:41:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 6 Aug 2018 17:41:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     "Lee, Chun-Yi" <jlee@suse.com>, Darren Hart <dvhart@infradead.org>,
        "Andy Shevchenko" <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] platform/x86: acer-wmi: use true and false for boolean
 values
Thread-Topic: [PATCH] platform/x86: acer-wmi: use true and false for boolean
 values
Thread-Index: AQHULKb/gFBLbM8qi0+aiFA6xA6TmKSy7ufg
Date:   Mon, 6 Aug 2018 16:41:17 +0000
Message-ID: <e92131c3b6e04a848f2a7922719f4747@AcuMS.aculab.com>
References: <20180805001839.GA22975@embeddedor.com>
 <CAHp75Vc=HLMVhQ30z9LTM7z+nmYgYPSRJib0PVTVW8H25eYg5g@mail.gmail.com>
In-Reply-To: <CAHp75Vc=HLMVhQ30z9LTM7z+nmYgYPSRJib0PVTVW8H25eYg5g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
MIME-Version: 1.0
X-MC-Unique: BWwyAWdDOHi05sizLNub4g-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDA1IEF1Z3VzdCAyMDE4IDExOjI2DQo+IA0K
PiBPbiBTdW4sIEF1ZyA1LCAyMDE4IGF0IDM6MTggQU0sIEd1c3Rhdm8gQS4gUi4gU2lsdmENCj4g
PGd1c3Rhdm9AZW1iZWRkZWRvci5jb20+IHdyb3RlOg0KPiA+IFJldHVybiBzdGF0ZW1lbnRzIGlu
IGZ1bmN0aW9ucyByZXR1cm5pbmcgYm9vbCBzaG91bGQgdXNlIHRydWUgb3IgZmFsc2UNCj4gPiBp
bnN0ZWFkIG9mIGFuIGludGVnZXIgdmFsdWUuDQo+ID4NCj4gPiBUaGlzIGNvZGUgd2FzIGRldGVj
dGVkIHdpdGggdGhlIGhlbHAgb2YgQ29jY2luZWxsZS4NCj4gDQo+ID4gIHN0YXRpYyBib29sIGhh
c19jYXAodTMyIGNhcCkNCj4gPiAgew0KPiA+ICAgICAgICAgaWYgKChpbnRlcmZhY2UtPmNhcGFi
aWxpdHkgJiBjYXApICE9IDApDQo+ID4gLSAgICAgICAgICAgICAgIHJldHVybiAxOw0KPiA+ICsg
ICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCj4gPg0KPiA+IC0gICAgICAgcmV0dXJuIDA7DQo+
ID4gKyAgICAgICByZXR1cm4gZmFsc2U7DQo+ID4gIH0NCj4gDQo+IHRoaXMgZW50aXJlIGZ1bmN0
aW9uIGNhbiBiZSBvbmVsaW5lcjoNCj4gDQo+IHJldHVybiAhISguLi4pOw0KDQpXaHkgdGhlICEh
ID8/IEp1c3Q6DQoJcmV0dXJuIChpbnRlcmZhY2UtPmNhcGFiaWxpdHkgJiBjYXApICE9IDA7DQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


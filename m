Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFFF2805C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFFF2805C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935288AbeF2P21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:28:27 -0400
Received: from smtp-out6.electric.net ([192.162.217.187]:63862 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932078AbeF2P20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:28:26 -0400
Received: from 1fYvJu-000kER-TQ by out6e.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fYvJv-000kIg-Tb; Fri, 29 Jun 2018 08:28:23 -0700
Received: by emcmailer; Fri, 29 Jun 2018 08:28:23 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6e.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fYvJu-000kER-TQ; Fri, 29 Jun 2018 08:28:22 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 29 Jun 2018 16:30:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 29 Jun 2018 16:30:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'YueHaibing' <yuehaibing@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "mawilcox@microsoft.com" <mawilcox@microsoft.com>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
Thread-Topic: [PATCH] lib/string.c: fix a typo in comment: 'iff' -->'if'
Thread-Index: AQHUD1vM59sGAblFJEWvECe+yN1p0qR3XR5w
Date:   Fri, 29 Jun 2018 15:30:01 +0000
Message-ID: <6d223fd7e9b74075be886b21189d8b50@AcuMS.aculab.com>
References: <20180629033303.13012-1-yuehaibing@huawei.com>
 <a0b2a088-4887-e864-d211-bed0665a0b81@infradead.org>
 <22bb151b-d651-597b-21b6-0e6346ac32c9@huawei.com>
In-Reply-To: <22bb151b-d651-597b-21b6-0e6346ac32c9@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (s)
X-Virus-Status: Scanned by VirusSMART (c)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWXVlSGFpYmluZw0KPiBTZW50OiAyOSBKdW5lIDIwMTggMDQ6NDUNCj4gDQo+IE9uIDIw
MTgvNi8yOSAxMTozNSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+IE9uIDA2LzI4LzIwMTggMDg6
MzMgUE0sIFl1ZUhhaWJpbmcgd3JvdGU6DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJpbmcg
PHl1ZWhhaWJpbmdAaHVhd2VpLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBsaWIvc3RyaW5nLmMgfCAy
ICstDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gPg0KPiA+IEhpLA0KPiA+DQo+ID4gVGhpcyBpc24ndCBhIHR5cG8uICAiaWZmIiBtZWFucyAi
aWYgYW5kIG9ubHkgaWYiLg0KPiANCj4gb2ssIG15IHBvb3IgZW5nbGlzaCwgdGhhbmsgeW91Lg0K
DQpJdCdzIG5vdCByZWFsbHkgZW5nbGlzaCwgYnV0IGEgc2hvcnRoYW5kIHVzZWQgYnkgbWF0aGVt
YXRpY2lhbnMuDQoNCglEYXZpZA0KDQo=

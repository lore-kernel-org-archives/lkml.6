Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D16C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D620892
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 05:43:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A7D620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbeKJP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:27:17 -0500
Received: from mail2.tencent.com ([163.177.67.195]:57745 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJP1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:27:16 -0500
Received: from EXHUB-SZMAIL02.tencent.com (unknown [10.14.6.23])
        by mail2.tencent.com (Postfix) with ESMTP id 833F78EC50;
        Sat, 10 Nov 2018 13:43:30 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMAIL02.tencent.com ([::1]) with mapi id 14.03.0415.000; Sat, 10 Nov
 2018 13:43:30 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     tkjos <tkjos@google.com>
CC:     gregkh <gregkh@linuxfoundation.org>, arve <arve@android.com>,
        tkjos <tkjos@android.com>, akpm <akpm@linux-foundation.org>,
        dave <dave@stgolabs.net>, devel <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chouryzhou <chouryzhou@gmail.com>
Subject: Re: Re: [PATCH V3] binder: ipc namespace support for android
 binder(Internet mail)
Thread-Topic: Re: [PATCH V3] binder: ipc namespace support for android
 binder(Internet mail)
Thread-Index: AQHUeLhPtOYTBQK4W0qDcZvrIjzt6Q==
Date:   Sat, 10 Nov 2018 05:43:30 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F8A65C@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>,
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSEx=z_CCfM5dmdm_cVtH-Az5eKCL5N_S-52qqSsMmGDUbQ@mail.gmail.com>,
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A4B2@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSEwjNYu1345KFvkTTvvy6Qb+T6=4WXEZ-t8wcGtkCUa_UA@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.195.149]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+Cj4gPiBJZiBJUENfTlMgaXMgZGlzYWJsZWQsICJjdXJyZW50LW5zcG9yeHktPmlwY19ucyIg
d2lsbCBhbHNvIGV4aXN0cyzCoCBpdCB3aWxsIGJlIGEgc3RhdGljCj4gPiByZWZlcmVuY2Ugb2Yg
ImluaXRfaXBjX25zIiAoaW4gaXBjL21zZ3V0aWwuYywgbm90IGRlZmluZWQgaW4gYmluZGVyLmMg
YnkgbWUpIHdpdGgKPiA+IG5vIG5hbWVzcGFjZS1pemF0aW9uLiBZb3Ugd2lsbCBnZXQgdGhlIHNh
bWUgb25lIGluIGFsbCBwcm9jZXNzZXMsIGV2ZXJ5dGhpbmcgaXMKPiA+IHRoZSBzYW1lIGFzwqAg
d2l0aG91dCB0aGlzIHBhdGNoLgo+wqAKPiBleGNlcHQsIGFzIGZhciBhcyBJIGNhbiB0ZWxsLCBi
aW5kZXJfaW5pdF9ucygpIHdvdWxkIG5ldmVyIGhhdmUgYmVlbgo+IGNhbGxlZCBvbiBpdCBzbyB0
aGUgbXV0ZXggYW5kIGxpc3QgaGVhZHMgYXJlIG5vdCBpbml0aWFsaXplZCBzbyBpdHMKPiBjb21w
bGV0ZWx5IGJyb2tlbi4gQW0gSSBtaXNzaW5nIHNvbWV0aGluZz8gSG93IGRvIHRob3NlIGZpZWxk
cyBnZXQKPiBpbml0aWFsaXplZCBpbiB0aGlzIGNhc2U/Cgo+IEBAIC01ODMyLDggKzU4ODgsMTIg
QEAgc3RhdGljIGludCBfX2luaXQgYmluZGVyX2luaXQodm9pZCkKPiDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBnb3RvIGVycl9pbml0X2JpbmRlcl9kZXZpY2VfZmFpbGVkOwo+
IMKgIMKgIMKgIMKgIH0KPgo+IC0gwqAgwqAgwqAgcmV0dXJuIHJldDsKPiArIMKgIMKgIMKgIHJl
dCA9IGJpbmRlcl9pbml0X25zKCZpbml0X2lwY19ucyk7Cj4gKyDCoCDCoCDCoCBpZiAocmV0KQo+
ICsgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZ290byBlcnJfaW5pdF9uYW1lc3BhY2VfZmFpbGVkOwo+
Cj4gKyDCoCDCoCDCoCByZXR1cm4gcmV0OwoKVGhleSBhcmUgaW5pdGlhbGl6ZWQgaGVyZS4KCi0g
Y2hvdXJ5IC0KCg==

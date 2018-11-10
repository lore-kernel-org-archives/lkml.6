Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E490C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F7D20825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 03:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F7D20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbeKJMxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 07:53:03 -0500
Received: from mail2.tencent.com ([163.177.67.195]:43598 "EHLO
        mail2.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbeKJMxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 07:53:03 -0500
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail2.tencent.com (Postfix) with ESMTP id 97C9517B9C;
        Sat, 10 Nov 2018 11:09:35 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail01.tencent.com ([::1]) with mapi id 14.03.0415.000; Sat, 10 Nov
 2018 11:09:35 +0800
From:   =?utf-8?B?Y2hvdXJ5emhvdSjlkajlqIEp?= <chouryzhou@tencent.com>
To:     tkjos <tkjos@google.com>
CC:     gregkh <gregkh@linuxfoundation.org>, arve <arve@android.com>,
        tkjos <tkjos@android.com>, akpm <akpm@linux-foundation.org>,
        dave <dave@stgolabs.net>, devel <devel@driverdev.osuosl.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chouryzhou <chouryzhou@gmail.com>
Subject: Re: Re: [PATCH V3] binder: ipc namespace support for android binder
Thread-Topic: Re: [PATCH V3] binder: ipc namespace support for android binder
Thread-Index: AQHUeKLO0YdSY8ul7U2/F7Lwer0RZw==
Date:   Sat, 10 Nov 2018 03:09:34 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>
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

PsKgCj4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5kIHRoZSBkZXBlbmRlbmNpZXMgb24gU1lTVklQ
QyBvciBQT1NJWF9NUVVFVUUuCj4gSXQgc2VlbXMgbGlrZSB0aGlzIG1lY2hhbmlzbSB3b3VsZCB3
b3JrIGV2ZW4gaWYgYm90aCBhcmUgZGlzYWJsZWQgLS0KPiBhcyBsb25nIGFzIElQQ19OUyBpcyBl
bmFibGVkLiBTZWVtcyBjbGVhbmVyIHRvIGNoYW5nZSBpbml0L0tjb25maWcgYW5kCj4gYWxsb3cg
SVBDX05TIGlmIENPTkZJR19BTkRST0lEX0JJTkRFUl9JUEMgYW5kIGNoYW5nZSB0aGlzIGxpbmUg
dG8KPiAiI2lmbmRlZiBDT05GSUdfSVBDX05TIgoKTGV0IG1lIGV4cGxhaW4gaXQgaW4gZGV0YWls
LiBJZiBTWVNJUEMgYW5kIElQQ19OUyBhcmUgYm90aCBkZWZpbmVkLCDCoApjdXJyZW50LT5uc3By
b3h5LT5pcGNfbnMgd2lsbCBzYXZlIHRoZSBpcGMgbmFtZXNwYWNlIHZhcmlhYmxlcy4gV2UganVz
dCB1c2XCoAppdC4gSWYgU1lTSVBDIChvciBQT1NJWF9NUVVFVUUpIGlzIGRlZmluZWQgd2hpbGUg
SVBDX05TIGlzIG5vdCBzZXQswqAKY3VycmVudC0+bnNwcm94eS0+aXBjX25zIHdpbGwgYWx3YXlz
IHJlZmVyIHRvIGluaXRfaXBjX25zIGluIGlwYy9tc2d1dGlsLmMswqAKd2hpY2ggaXMgYWxzbyBm
aW5lIHRvIHVzLiBCdXQgaWYgbmVpdGhlciBTWVNJUEMgbm9yIFBPU0lYX01RVUVVRSBpcyBzZXTC
oAooSVBDX05TIGNhbid0IGJlIHNldCBpbiB0aGlzIHNpdHVhdGlvbiksIHRoZXJlIGlzIG5vIGN1
cnJlbnQtPm5zcHJveHktPmlwY19ucy4KV2UgbWFrZSBhIGZhY2sgaW5pdF9pcGNfbnMgaGVyZSBh
bmQgdXNlIGl0LgoKPiB3aHkgZWxpbWluYXRlIG5hbWU/IFRoZSBzdHJpbmcgbmFtZSBpcyB2ZXJ5
IHVzZWZ1bCBmb3IgZGlmZmVyZW50aWF0aW5nCj4gbm9ybWFsICJmcmFtZXdvcmsiIGJpbmRlciB0
cmFuc2FjdGlvbnMgdnMgImhhbCIgb3IgInZlbmRvciIKPiB0cmFuc2FjdGlvbnMuIElmIHdlIGp1
c3QgaGF2ZSBhIGRldmljZSBudW1iZXIgaXQgd2lsbCBiZSBoYXJkIHRvIHRlbGwKPiBpbiB0aGUg
bG9ncyBldmVuIHdoaWNoIG5hbWVzcGFjZSBpdCBiZWxvbmdzIHRvLiBXZSBuZWVkIHRvIGtlZXAg
Ym90aAo+IHRoZSAibmFtZSIgKGZvciB3aGljaCB0aGVyZSBtaWdodCBiZSBtdWx0aXBsZSBpbiBl
YWNoIG5zKSBhbmQgc29tZQo+IGluZGljYXRpb24gb2Ygd2hpY2ggbmFtZXNwYWNlIHRoaXMgaXMu
IE1heWJlIHdlIGFzc2lnbiBzb21lIHNvcnQgb2YKPiBuYW1lc3BhY2UgSUQgZHVyaW5nIGJpbmRl
cl9pbml0X25zKCkuCgrCoEkgd2lsbCByZW1haW4gdGhlIG5hbWUgb2YgZGV2aWNlLiBUaGUgwqBp
bnVtIG9mIGlwY19ucyBjYW4gYmUgdHJlYXRlZCBhc8KgCm5hbWVzcGFjZSBJRCBpbiBpcGNfbnMu
Cgo+IEFzIG1lbnRpb25lZCBhYm92ZSwgd2UgbmVlZCB0byByZXRhaW4gbmFtZSBhbmQgcHJvYmFi
bHkgYWxzbyB3YW50IGEgbnMKPiBpZCBvZiBzb21lIHNvcnQuIFNvIGNvbnRleHQgbm93IGhhcyAz
IGNvbXBvbmVudHMgaWYgSVBDX05TLCBzbyBtYXliZSBhCj4gaGVscGVyIGZ1bmN0aW9uIHRvIHBy
aW50IGNvbnRleHQgbGlrZToKPsKgCj4gc3RhdGljIHZvaWQgYmluZGVyX3NlcV9wcmludF9jb250
ZXh0KHN0cnVjdCBzZXFfZmlsZSAqbSwgc3RydWN0Cj4gYmluZGVyX2NvbnRleHQgKmNvbnRleHQp
Cj4gewo+ICNpZmRlZiBDT05GSUdfSVBDX05TCj4gwqAgwqAgwqAgwqAgwqAgc2VxX3ByaW50Ziht
LCAiJWQtJWQtJXMiLCBjb250ZXh0LT5uc19pZCwgY29udGV4dC0+ZGV2aWNlLAo+IGNvbnRleHQt
Pm5hbWUpOwo+ICNlbHNlCj4gwqAgwqAgwqAgwqAgwqAgc2VxX3ByaW50ZihtLCAiJWQiLCBjb250
ZXh0LT5uYW1lKTsKPiAjZW5kaWYKPiB9Cj7CoAo+IChzYW1lIGNvbW1lbnQgYmVsb3cgZXZlcnl3
aGVyZSBjb250ZXh0IGlzIHByaW50ZWQpCj7CoAo+IFNob3VsZCB0aGVzZSBkZWJ1Z2ZzIG5vZGVz
IHNob3VsZCBiZSBucyBhd2FyZSBhbmQgb25seSBwcmludCBkZWJ1Z2dpbmcKPiBpbmZvIGZvciB0
aGUgY29udGV4dCBvZiB0aGUgdGhyZWFkIGFjY2Vzc2luZyB0aGUgbm9kZT8gSWYgc28sIHdlIHdv
dWxkCj4gYWxzbyB3YW50IHRvIGJlIG5hbWVzcGFjZS1hd2FyZSB3aGVuIHByaW50aW5nIHBpZHMu
CgpOb3dhZGF5cywgZGVidWdmcyBpcyBub3QgbmFtZXNwYWNlLWl6ZWQsIGFuZCBwaWQgbmFtZXNw
YWNlIGlzIG5vdCBhc3NvY2lhdGVkwqAKd2l0aCBpcGMgbmFtZXNwYWNlLiDCoFdpbGwgaXQgYmUg
bW9yZSBjb21wbGljYXRlZCB0byBkZWJ1ZyB0aGlzIGlmIHdlIGp1c3QgcHJpbnTCoAp0aGUgaW5m
byBmb3IgY3VycmVudCB0aHJlYWQ/IEJlY2F1c2Ugd2Ugd2lsbCBoYXZlIHRvIGVudGVyIHRoZSBp
cGMgbmFtZXNwYWNlwqAKZmlyc3RseS4gQnV0IGFkZCBpcGMgaW51bSBzaG91bGQgYmUgbm8gcHJv
YmxlbS4KCi0gY2hvdXJ5IC0KCgo=

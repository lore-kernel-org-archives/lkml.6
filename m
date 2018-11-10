Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C98C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275EB20825
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:00:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 275EB20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tencent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeKJPnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 10:43:46 -0500
Received: from mail4.tencent.com ([183.57.53.109]:47559 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 10:43:46 -0500
Received: from EXHUB-SZMail01.tencent.com (unknown [10.14.6.21])
        by mail4.tencent.com (Postfix) with ESMTP id 451C150873;
        Sat, 10 Nov 2018 12:43:09 +0800 (CST)
Received: from EXMBX-SZMAIL022.tencent.com ([fe80::dcc:e364:cd45:89d9]) by
 EXHUB-SZMail01.tencent.com ([::1]) with mapi id 14.03.0415.000; Sat, 10 Nov
 2018 12:43:09 +0800
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
Thread-Index: AQHUeK5lmUFblhQvVUuvyxEdyq5goA==
Date:   Sat, 10 Nov 2018 04:43:08 +0000
Message-ID: <5FBCBE569E134E4CA167B91C0A77FD610198F8A4B2@EXMBX-SZMAIL022.tencent.com>
References: <5FBCBE569E134E4CA167B91C0A77FD610198F851AC@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSExukqyS5V=fgdBP1Jn_KXZEMsWR+wMLNtxBq8+G3wkgSQ@mail.gmail.com>,
 <5FBCBE569E134E4CA167B91C0A77FD610198F8A217@EXMBX-SZMAIL022.tencent.com>,
 <CAHRSSEx=z_CCfM5dmdm_cVtH-Az5eKCL5N_S-52qqSsMmGDUbQ@mail.gmail.com>
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

Cj4gPiA+IEkgc3RpbGwgZG9uJ3QgdW5kZXJzdGFuZCB0aGUgZGVwZW5kZW5jaWVzIG9uIFNZU1ZJ
UEMgb3IgUE9TSVhfTVFVRVVFLgo+ID4gPiBJdCBzZWVtcyBsaWtlIHRoaXMgbWVjaGFuaXNtIHdv
dWxkIHdvcmsgZXZlbiBpZiBib3RoIGFyZSBkaXNhYmxlZCAtLQo+ID4gPiBhcyBsb25nIGFzIElQ
Q19OUyBpcyBlbmFibGVkLiBTZWVtcyBjbGVhbmVyIHRvIGNoYW5nZSBpbml0L0tjb25maWcgYW5k
Cj4gPiA+IGFsbG93IElQQ19OUyBpZiBDT05GSUdfQU5EUk9JRF9CSU5ERVJfSVBDIGFuZCBjaGFu
Z2UgdGhpcyBsaW5lIHRvCj4gPiA+ICIjaWZuZGVmIENPTkZJR19JUENfTlMiCj4gPgo+ID4gTGV0
IG1lIGV4cGxhaW4gaXQgaW4gZGV0YWlsLiBJZiBTWVNJUEMgYW5kIElQQ19OUyBhcmUgYm90aCBk
ZWZpbmVkLAo+ID4gY3VycmVudC0+bnNwcm94eS0+aXBjX25zIHdpbGwgc2F2ZSB0aGUgaXBjIG5h
bWVzcGFjZSB2YXJpYWJsZXMuIFdlIGp1c3QgdXNlCj4gPiBpdC4gSWYgU1lTSVBDIChvciBQT1NJ
WF9NUVVFVUUpIGlzIGRlZmluZWQgd2hpbGUgSVBDX05TIGlzIG5vdCBzZXQsCj4gPiBjdXJyZW50
LT5uc3Byb3h5LT5pcGNfbnMgd2lsbCBhbHdheXMgcmVmZXIgdG8gaW5pdF9pcGNfbnMgaW4gaXBj
L21zZ3V0aWwuYywKPiA+IHdoaWNoIGlzIGFsc28gZmluZSB0byB1cy4gQnV0IGlmIG5laXRoZXIg
U1lTSVBDIG5vciBQT1NJWF9NUVVFVUUgaXMgc2V0Cj4gPiAoSVBDX05TIGNhbid0IGJlIHNldCBp
biB0aGlzIHNpdHVhdGlvbiksIHRoZXJlIGlzIG5vIGN1cnJlbnQtPm5zcHJveHktPmlwY19ucy4K
PiA+IFdlIG1ha2UgYSBmYWNrIGluaXRfaXBjX25zIGhlcmUgYW5kIHVzZSBpdC4KPsKgCj4gWWVz
LCBJIGNhbiByZWFkIHRoZSBjb2RlLiBJJ20gd29uZGVyaW5nIHNwZWNpZmljYWxseSBhYm91dCBT
WVNWSVBDIGFuZAo+IFBPU0lYX01RVUVVRS4gRXZlbiB3aXRoIHlvdXIgY29kZSBjaGFuZ2VzLCBi
aW5kZXIgaGFzIG5vIGRlcGVuZGVuY3kgb24KPiB0aGVzZSBjb25maWdzLiBXaHkgYXJlIHlvdSBj
cmVhdGluZyBvbmU/IFRoZSBhY3R1YWwgZGVwZW5kZW5jeSB3aXRoCj4geW91ciBjaGFuZ2VzIGlz
IG9uICJjdXJyZW50LT5uc3Byb3h5LT5pcGNfbnMiIGJlaW5nIGluaXRpYWxpemVkIGZvcgo+IGJp
bmRlciAtLSB3aGljaCBpcyBkZXBlbmRlbnQgb24gQ09ORklHX0lQQ19OUyBiZWluZyBlbmFibGVk
LCBpc24ndCBpdD8KPsKgCj4gSWYgU1lTVklQQyBvciBQT1NJWF9NUVVFVUUgYXJlIGVuYWJsZWQs
IGJ1dCBJUENfTlMgaXMgZGlzYWJsZWQsIGRvZXMgdGhpcyB3b3JrPyAKCklmIElQQ19OUyBpcyBk
aXNhYmxlZCwgImN1cnJlbnQtbnNwb3J4eS0+aXBjX25zIiB3aWxsIGFsc28gZXhpc3RzLCDCoGl0
IHdpbGwgYmUgYSBzdGF0aWMgCnJlZmVyZW5jZSBvZiAiaW5pdF9pcGNfbnMiIChpbiBpcGMvbXNn
dXRpbC5jLCBub3QgZGVmaW5lZCBpbiBiaW5kZXIuYyBieSBtZSkgd2l0aCAKbm8gbmFtZXNwYWNl
LWl6YXRpb24uIFlvdSB3aWxsIGdldCB0aGUgc2FtZSBvbmUgaW4gYWxsIHByb2Nlc3NlcywgZXZl
cnl0aGluZyBpcyAKdGhlIHNhbWUgYXMgwqB3aXRob3V0IHRoaXMgcGF0Y2guCgotIGNob3VyeSAt
Cgo=
